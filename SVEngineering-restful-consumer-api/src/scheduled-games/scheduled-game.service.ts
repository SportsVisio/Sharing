import { TeamScheduledGameAssn } from './scheduled-game-team-assn.entity';
import { ScheduledGame } from './scheduled-game.entity';
import { logger } from './../common/logger';
import { Injectable, BadRequestException } from '@nestjs/common';
import { FindManyOptions, FindOneOptions, Repository } from 'typeorm';
import { InjectRepository } from "@nestjs/typeorm";
import { ScheduleGamePayloadBase, UpdateScheduledGamePayload } from "./scheduled-game.classes";
import { PromisedNotFoundException } from "../common/constants";

@Injectable()
export class ScheduledGameService {
  constructor(
    @InjectRepository(ScheduledGame)
    public games: Repository<ScheduledGame>,
    @InjectRepository(TeamScheduledGameAssn)
    public teamAssignments: Repository<TeamScheduledGameAssn>
  ) { }

  public async list(accountId: string, options?: Partial<FindManyOptions<ScheduledGame>>): Promise<ScheduledGame[]> {
    return this.games.find({
      where: {
        account: {
          id: accountId
        }
      },
      ...options
    });
  }

  public get(gameId: string, options?: Partial<FindOneOptions<ScheduledGame>>): Promise<ScheduledGame> {
    return this.games.findOneOrFail(gameId, options).catch(PromisedNotFoundException);
  }

  public create(accountId: string, { leagueId, courtId, teams, season, ...rest }: ScheduleGamePayloadBase): Promise<ScheduledGame> {
    if (!teams || teams.length < 2) throw new BadRequestException("Must provide at least 2 teams to schedule a game");

    return this.games.create({
      account: { id: accountId },
      league: { id: leagueId || null },
      court: { id: courtId || null },
      season,
      teamGameAssn: teams.map(({ teamId, color, designation }) => this.teamAssignments.create({
        team: { id: teamId },
        designation,
        color
      })),
      processedVideoUrl: "",
      ...rest
    }).save();
  }

  public async update(id: string, { leagueId, courtId, ...rest}: UpdateScheduledGamePayload): Promise<boolean> {
    const game = await this.get(id);
    if (leagueId) game.league.id = leagueId;
    if (courtId) game.court.id = courtId;

    return Object.assign(game, rest).save().then(() => true);
  }
}
