import { TeamsController } from './teams.controller';
import { TeamPlayer } from './team-player.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { SharedModule } from '../shared/shared.module';
import { Team } from "./team.entity";
import { TeamService } from "./teams.service";

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Team,
      TeamPlayer
    ]),
    SharedModule
  ],
  providers: [
    TeamService
  ],
  exports: [
    TypeOrmModule,
    TeamService
  ],
  controllers: [
    TeamsController
  ]
})
export class TeamsModule {}
