import { DevicesService } from './../device/device.service';
import { ScheduledGameService } from './../scheduled-games/scheduled-game.service';
import { IAnnotationImport } from './annotations.classes';
import { S3Service } from './../shared/s3.service';
import { Annotation, AnnotationSources } from './annotation.entity';
import { Injectable, BadRequestException } from '@nestjs/common';
import { Repository, Transaction } from 'typeorm';
import { InjectRepository } from "@nestjs/typeorm";
import { AnnotationActor, AnnotationActorTypes } from "./annotation-actor.entity";
import { AnnotationActorQualifier } from "./annotation-actor-qualifier.entity";
import { AnnotationAction } from "./annotation-action.entity";
import { AnnotationActionQualifier } from "./annotation-action-qualifier.entity";
import { logger } from "../common/logger";
import { TeamService } from "../teams/teams.service";
import { PromisedNotFoundException } from "../common/constants";
import { TeamPlayer } from "../teams/team-player.entity";

const S3_BUCKETBASE = `${process.env.ANNOTATION_S3_BUCKET || "annotation-ar-output"}`;

@Injectable()
export class AnnotationService {
  constructor(
    @InjectRepository(Annotation)
    public annotations: Repository<Annotation>,
    @InjectRepository(AnnotationActor)
    public actors: Repository<AnnotationActor>,
    @InjectRepository(AnnotationActorQualifier)
    public actorQualifiers: Repository<AnnotationActorQualifier>,
    @InjectRepository(AnnotationAction)
    public actions: Repository<AnnotationAction>,
    @InjectRepository(AnnotationActionQualifier)
    public actionQualifiers: Repository<AnnotationActionQualifier>,
    private s3: S3Service,
    private teams: TeamService,
    private games: ScheduledGameService
  ) { }

  public async import(scheduledGameId: string, source: AnnotationSources, payload: IAnnotationImport): Promise<boolean> {
    const scheduledGame = await this.games.games.findOneOrFail(scheduledGameId, {
      relations: ["game", "game.teamGameAssn"]
    }).catch(PromisedNotFoundException);
    
    const teamAssn = scheduledGame.teamGameAssn;
    if (teamAssn.length !== 2) throw new BadRequestException("This game is incorrectly conigured to receive annotations. Teams < 2");

    const {
      "data-id": dataId,
      "video-name": videoName,
      "input-type": inputType,
      "frame-resolution": frameResolution,
      "frame-rate": frameRate,
      "frame-skip": frameSkip,
      "processing-window-size": processingWindowSize,
      "processing-window-overlap": processingWindowOverlap,
      ids: actors,
      actions
    } = payload;

    const s3Obj = await this.s3.writeObject(S3_BUCKETBASE, `${videoName}.json`, process.env.NODE_ENV || "dev", JSON.stringify(payload));

    const annotation = await this.annotations.create({
      source,
      scheduledGame,
      s3ETag: s3Obj.ETag,
      videoName,
      inputType,
      frameResolution,
      frameRate,
      frameSkip,
      processingWindowSize,
      processingWindowOverlap
    }).save();

    const actorIds = Object.keys(actors);

    // create the individual actor and actorQualifier records
    const _actors = await Promise.all(
      actorIds.map(identifier => {
        const { type, designation, attributes = [] } = actors[identifier];
        return this.actors.create({
          annotation,
          identifier,
          type,
          designation,
          qualifiers: attributes.map(qualifier => this.actorQualifiers.create({
            qualifier
          }))
        }).save();
      })
    );

    // DRY
    const jerseyFinder = ({ qualifier }) => qualifier.match(/jersey-[0-9]{1,2}/i);
    const linkActor = (player: TeamPlayer, actor: AnnotationActor): Promise<AnnotationActor> => {
      actor.teamPlayer = player;
      return actor.save();
    };

    // build out team rosters from actors
    await Promise.all(
      _actors
        // only player actors
        .filter(({ type }) => type.toLowerCase() === AnnotationActorTypes.PLAYER)
        // only players with a jersey number detected
        .filter(({ qualifiers }) => qualifiers.find(jerseyFinder))
        .map(actor => {
          try {
            const { identifier, qualifiers } = actor;
            const teamColor = identifier.split("-")[0];
            if (!teamColor) throw new Error();

            const { team } = teamAssn.find(({ color }) => color.toLowerCase() === teamColor);
            const [, number] = qualifiers.find(jerseyFinder).qualifier.split("-");

            const player = team.players.find(({ number: _number }) => _number === number);

            return player ? linkActor(player, actor) : this.teams.createPlayer(team.id, {
              name: "",
              number
            }).then(p => linkActor(p, actor));
          }
          catch (exc) {
            logger.error(exc);
            return Promise.resolve(actor);
          }
        })
    );

    // create the individual action and actionQualifier records
    await Promise.all(
      actions.map(({
        "start-time": startTime,
        "start-frame": startFrame,
        action,
        "action-qualifier": qualifiers,
        "action-confidence": confidence,
        "player-id": playerId,
        "player-location": location
      }) => {
        const obj = {
          action,
          actor: _actors.find(({ identifier }) => identifier === playerId),
          startTime,
          startFrame,
          confidence,
          qualifiers: qualifiers.map(qualifier => this.actionQualifiers.create({
            qualifier
          })),
          location
        };
        return this.actions.create(obj).save();
      })
    );

    // TODO - location tracking?

    return Promise.resolve(true);
  }
}
