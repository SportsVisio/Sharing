import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { SharedModule } from '../shared/shared.module';
import { League } from "./league.entity";
import { LeagueService } from "./leagues.service";
import { LeaguesController } from "./leagues.controller";

@Module({
  imports: [
    TypeOrmModule.forFeature([
      League
    ]),
    SharedModule
  ],
  providers: [
    LeagueService
  ],
  exports: [
    TypeOrmModule,
    LeagueService
  ],
  controllers: [
    LeaguesController
  ]
})
export class LeaguesModule {}
