import { TeamPlayer } from './team-player.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { logger } from './../common/logger';
import { Injectable } from '@nestjs/common';
import { Team } from "./team.entity";
import { FindManyOptions, Repository } from "typeorm";
import { PromisedNotFoundException } from "../common/constants";
import { CreateTeamPayload, CreateTeamPlayerPayload, UpdateTeamPayload, UpdateTeamPlayerPayload } from "./team.classes";

@Injectable()
export class TeamService {
  constructor(
    @InjectRepository(Team)
    public teams: Repository<Team>,
    @InjectRepository(TeamPlayer)
    public players: Repository<TeamPlayer>,
  ) {
  }

  public search(search: string): Promise<Team[]> {
    const _search = `%${search}%`;

    return this.teams.createQueryBuilder("teams")
      .where("name like :searchname", { searchname: _search })
      .getMany();
  }

  public async list(accountId: string): Promise<Team[]> {
    return this.teams.find({
      where: {
        account: {
          id: accountId
        }
      },
    });
  }

  public get(teamId: string, options?: Partial<FindManyOptions<Team>>): Promise<Team> {
    return this.teams.findOneOrFail(teamId, options).catch(PromisedNotFoundException);
  }

  public create(accountId: string, { name, imageUrl }: CreateTeamPayload): Promise<Team> {
    return this.teams.create({
      account: {
        id: accountId
      },
      name,
      imageUrl
    }).save();
  }

  public async createPlayer(teamId: string, { name, number }: CreateTeamPlayerPayload): Promise<TeamPlayer> {
    const team = await this.get(teamId);

    return this.players.create({
      team,
      name,
      number
    }).save();
  }

  public async update(id: string, data: UpdateTeamPayload): Promise<boolean> {
    const team = await this.get(id);
    return Object.assign(team, data).save().then(() => true);
  }

  public async updatePlayer(id: string, data: UpdateTeamPlayerPayload): Promise<boolean> {
    const player = await this.players.findOneOrFail(id).catch(PromisedNotFoundException);
    return Object.assign(player, data).save().then(() => true);
  }
}
