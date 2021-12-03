import { Court } from './court.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { logger } from './../common/logger';
import { Injectable } from '@nestjs/common';
import { Arena } from "./arena.entity";
import { FindManyOptions, Repository } from "typeorm";
import { PromisedNotFoundException } from "../common/constants";
import { CreateArenaCourtPayload, UpdateArenaPayload, UpdateArenaCourtPayload, CreateArenaPayload } from "./arena.classes";

@Injectable()
export class ArenaService {
  constructor(
    @InjectRepository(Arena)
    public arenas: Repository<Arena>,
    @InjectRepository(Court)
    public courts: Repository<Court>,
  ) {
  }

  public async list(): Promise<Arena[]> {
    return this.arenas.find();
  }

  public get(arenaId: string, options?: Partial<FindManyOptions<Arena>>): Promise<Arena> {
    return this.arenas.findOneOrFail(arenaId, options).catch(PromisedNotFoundException);
  }

  public getCourt(courtId: string): Promise<Court> {
    return this.courts.findOneOrFail(courtId).catch(PromisedNotFoundException);
  }

  public create({ name }: CreateArenaPayload): Promise<Arena> {
    return this.arenas.create({
      name
    }).save();
  }

  public async createCourt(arenaId: string, { name }: CreateArenaCourtPayload): Promise<boolean> {
    const arena = await this.get(arenaId);

    return this.courts.create({
      arena,
      name
    }).save().then(() => true);
  }

  public async update(id: string, data: UpdateArenaPayload): Promise<boolean> {
    const arena = await this.get(id);
    return Object.assign(arena, data).save().then(() => true);
  }

  public async updateCourt(id: string, data: UpdateArenaCourtPayload): Promise<boolean> {
    const court = await this.courts.findOneOrFail(id).catch(PromisedNotFoundException);
    return Object.assign(court, data).save().then(() => true);
  }

  public async delete(id: string): Promise<boolean> {
    return (await this.get(id))?.softRemove().then(() => true);
  }

  public async deleteCourt(id: string): Promise<boolean> {
    const court = await this.courts.findOneOrFail(id).catch(PromisedNotFoundException);

    return court.softRemove().then(() => true);
  }
}
