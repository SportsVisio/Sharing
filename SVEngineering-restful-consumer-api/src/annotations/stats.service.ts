import { Injectable } from '@nestjs/common';
import { getRepository } from 'typeorm';
import { AnnotationAction, AnnotationActions } from "./annotation-action.entity";
import { AnnotationActionQualifiers } from "./annotation-action-qualifier.entity";
import { PlayerStatRollup, PlayerStatSummary } from "./stats.classes";
import { AnnotationSources } from "./annotation.entity";

export interface IStatOptions {
  source: string;
  scheduledGameId?: string;
  leagueId?: string;
  arenaId?: string;
  teamId?: string;
  season?: string;
  profileId?: string;
}

@Injectable()
export class StatisticService {
  constructor() { }

  public async getActions(profileId: string, { source = AnnotationSources.AI, scheduledGameId, season, arenaId, leagueId, teamId, profileId: againstId }: IStatOptions): Promise<AnnotationAction[]> {
    const qry = await getRepository(AnnotationAction).createQueryBuilder("action")
      .innerJoin("action.annotation", "annotation", "annotation.source = :source", { source })
      .innerJoin("annotation.scheduledGame", "scheduledGame")      
      .innerJoinAndSelect("action.qualifiers", "qualifiers")
      .innerJoinAndSelect("action.actor", "actor")
      .innerJoinAndSelect("actor.teamPlayer", "teamPlayer")
      .innerJoinAndSelect("teamPlayer.playerProfileAssn", "playerProfileAssn")
      .where("playerProfileAssn.profileId = :profileId", { profileId });

    if (againstId) qry.orWhere("playerProfileAssn.profileId = :againstId", { againstId });

    if (scheduledGameId) qry.andWhere("annotation.scheduledGameId = :scheduledGameId", { scheduledGameId });
    if (season) qry.andWhere("scheduledGame.season like :season", { season });
    if (leagueId) qry.andWhere("scheduledGame.leagueId = :leagueId", { leagueId });
    if (arenaId) qry.andWhere("scheduledGame.arenaId = :arenaId", { arenaId });
    if (teamId) {
      // only need this join for this request
      qry.innerJoin("scheduldGame.teamGameAssn", "teamGameAssn", "teamGameAssn.teamId = :teamId", { teamId });
    }

    return qry.getMany();
  }

  public getStats(actions: AnnotationAction[]): PlayerStatSummary {
    const findActions = (action: AnnotationActions) => actions.filter(({ action: a }) => action === a);
    const findActionsByQualifier = (qualifier: AnnotationActionQualifiers) => actions.filter(({ qualifiers }) => {
      return qualifiers.find(({ qualifier: q }) => qualifier === q);
    });
    const reduceRollup = (prev, curr) => {
      if (curr.qualifiers.find(({ qualifier: q }) => AnnotationActionQualifiers.MADE === q)) prev.made++;
      else prev.attempts++;

      return prev;
    };
    const baseRollup: PlayerStatRollup = {
      made: 0,
      attempts: 0
    };

    const threePointActions = findActionsByQualifier(AnnotationActionQualifiers.THREE_POINT);
    const twoPointActions = findActionsByQualifier(AnnotationActionQualifiers.TWO_POINT);

    const summary = new PlayerStatSummary();
    summary.fieldGoals = [
      ...threePointActions,
      ...twoPointActions
    ].reduce(reduceRollup, baseRollup);

    summary.threePoints = [
      ...threePointActions,
    ].reduce(reduceRollup, baseRollup);

    summary.twoPoints = [
      ...twoPointActions
    ].reduce(reduceRollup, baseRollup);

    summary.freeThrows = [
      ...findActions(AnnotationActions.FREE_THROW),
    ].reduce(reduceRollup, baseRollup);

    summary.totalPoints = summary.fieldGoals.attempts + summary.fieldGoals.made;

    const reboundActions = findActions(AnnotationActions.REBOUND);

    summary.offensiveRebounds = reboundActions.filter(({ qualifiers }) => qualifiers.find(({ qualifier: q }) => q === AnnotationActionQualifiers.OFFENSIVE)).length;
    summary.defensiveRebounds = reboundActions.filter(({ qualifiers }) => qualifiers.find(({ qualifier: q }) => q === AnnotationActionQualifiers.DEFENSIVE)).length;

    summary.totalRebounds = summary.offensiveRebounds + summary.defensiveRebounds;

    // assists come with a `-id` tag on them. Just look for a base of assist for total rollup
    summary.assists = actions.filter(({ action }) => action.startsWith("assist")).length;

    return summary;
  }
}
