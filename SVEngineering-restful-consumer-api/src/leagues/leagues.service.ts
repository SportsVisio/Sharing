import { UpdateArenaPayload } from './../arenas/arena.classes';
import { InjectRepository } from '@nestjs/typeorm';
import { Injectable } from '@nestjs/common';
import { League } from "./league.entity";
import { FindManyOptions, Repository } from "typeorm";
import { PromisedNotFoundException } from "../common/constants";

@Injectable()
export class LeagueService {
  constructor(
    @InjectRepository(League)
    public leagues: Repository<League>,
  ) {
  }

  public async list(): Promise<League[]> {
    return this.leagues.find();
  }

  public get(leagueId: string, options?: Partial<FindManyOptions<League>>): Promise<League> {
    return this.leagues.findOneOrFail(leagueId, options).catch(PromisedNotFoundException);
  }

  public create({ name }: { name: string }): Promise<League> {
    return this.leagues.create({
      name
    }).save();
  }

  public async update(id: string, data: UpdateArenaPayload): Promise<boolean> {
    const league = await this.get(id);
    return Object.assign(league, data).save().then(() => true);
  }

  public async delete(id: string): Promise<boolean> {
    return (await this.get(id))?.softRemove().then(() => true);
  }
}
