import { IStatOptions } from './../annotations/stats.service';
import { PlayerProfile } from './player-profile.entity';
import { logger } from './../common/logger';
import { Injectable, BadRequestException } from '@nestjs/common';
import { FindManyOptions, Like, Repository } from 'typeorm';
import { InjectRepository } from "@nestjs/typeorm";
import { PlayerProfileTeamPlayerAssn } from "./player-profile-team-player-assn.entity";
import { PromisedNotFoundException } from "../common/constants";
import { PlayerProfileFollow } from "./player-profile-follow.entity";
import { PlayerStatSummary } from "../annotations/stats.classes";
import { StatisticService } from "../annotations/stats.service";

@Injectable()
export class PlayerProfileService {
  constructor(
    @InjectRepository(PlayerProfile)
    public profiles: Repository<PlayerProfile>,
    @InjectRepository(PlayerProfileTeamPlayerAssn)
    public profileAssn: Repository<PlayerProfileTeamPlayerAssn>,
    @InjectRepository(PlayerProfileFollow)
    public follows: Repository<PlayerProfileFollow>,
    public stats: StatisticService
  ) { }

  public search(search: string): Promise<PlayerProfile[]> {
    const _search = `%${search}%`;

    return this.profiles.createQueryBuilder("profile")
      .leftJoinAndSelect("profile.teamPlayerAssn", "teamPlayerAssn")
      .leftJoinAndSelect("teamPlayerAssn.player", "player")
      .leftJoinAndSelect("player.team", "team")
      .where("(profile.nickName like :searchname or profile.firstName like :searchname or profile.lastName like :searchname)", { searchname: _search})
      .orWhere("player.name like :playername", { playername: _search})
      .orWhere("team.name like :teamname", { teamname: _search})
      .getMany();
  }

  public get(profileId: string, options?: Partial<FindManyOptions<PlayerProfile>>): Promise<PlayerProfile> {
    return this.profiles.findOneOrFail(profileId, options).catch(PromisedNotFoundException);
  }

  public async getStats(profileId: string, options?: IStatOptions): Promise<PlayerStatSummary> {
    return this.stats.getStats(
      await this.stats.getActions(profileId, options)
    );
  }

  public async update(profileId: string, update: Partial<PlayerProfile>): Promise<boolean> {
    const profile = await this.get(profileId);
    return Object.assign(profile, update).save().then(() => true);
  }

  public getFollowing(profileId: string): Promise<PlayerProfile[]> {
    return this.follows.find({
      where: {
        follower: profileId
      },
      relations: [
        "following",
        "following.teamPlayerAssn",
        "following.teamPlayerAssn.player",
        "following.teamPlayerAssn.player.team",
      ]
    }).catch(PromisedNotFoundException).then(follows => follows.map(({ following }) => following));
  }

  // TODO - set approved to false when there's an approval GUI flow
  public async claimTeamPlayer(teamPlayerId: string, profileId: string, approved = true): Promise<boolean> {
    const profile = await this.get(profileId);
    profile.teamPlayerAssn.push(this.profileAssn.create({
      approved,
      player: {
        id: teamPlayerId
      }
    }));
    return profile.save().then(() => true);
  }

  public async follow(followingProfileId: string, followerProfileId: string): Promise<boolean> {
    const opts = {
      follower: {
        id: followerProfileId
      },
      following: {
        id: followingProfileId
      }
    };
    const records = await this.follows.find({
      where: opts
    });
    if (records.length) throw new BadRequestException("Already following this player");

    return this.follows.create(opts).save().then(() => true);
  }

  public async unfollow(followId: string): Promise<boolean> {
    return this.follows.delete(followId).then(() => true);
  }
}
