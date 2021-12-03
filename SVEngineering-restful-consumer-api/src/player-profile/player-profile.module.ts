import { AnnotationsModule } from './../annotations/annotations.module';
import { PlayerProfilesController } from './player-profile.controller';
import { PlayerProfileService } from './player-profile.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Module, forwardRef } from '@nestjs/common';
import { PlayerProfile } from "./player-profile.entity";
import { PlayerProfileTeamPlayerAssn } from "./player-profile-team-player-assn.entity";
import { PlayerProfileFollow } from "./player-profile-follow.entity";
import { StatisticService } from "../annotations/stats.service";

@Module({
  imports: [
    TypeOrmModule.forFeature([
      PlayerProfile,
      PlayerProfileTeamPlayerAssn,
      PlayerProfileFollow
    ]),
  ],
  providers: [
    PlayerProfileService,
    StatisticService
  ],
  exports: [
    PlayerProfileService,
    TypeOrmModule
  ],
  controllers: [
    PlayerProfilesController
  ]
})
export class PlayerProfileModule { }
