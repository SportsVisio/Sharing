import { PlayerProfileModule } from './../player-profile/player-profile.module';
import { DevicesModule } from './../device/device.module';
import { AnnotationsController } from './annotations.controller';
import { AnnotationActor } from './annotation-actor.entity';
import { Annotation } from './annotation.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { SharedModule } from '../shared/shared.module';
import { AnnotationActorQualifier } from "./annotation-actor-qualifier.entity";
import { AnnotationAction } from "./annotation-action.entity";
import { AnnotationActionQualifier } from "./annotation-action-qualifier.entity";
import { AnnotationService } from "./annotations.service";
import { TeamsModule } from "../teams/teams.module";
import { ScheduledGamesModule } from "../scheduled-games/scheduled-game.module";
import { StatisticService } from "./stats.service";

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Annotation,
      AnnotationActor,
      AnnotationActorQualifier,
      AnnotationAction,
      AnnotationActionQualifier
    ]),
    SharedModule,
    TeamsModule,
    ScheduledGamesModule,
    PlayerProfileModule,
    DevicesModule
  ],
  providers: [
    AnnotationService,
    StatisticService
  ],
  exports: [
    TypeOrmModule,
    AnnotationService
  ],
  controllers: [
    AnnotationsController
  ]
})
export class AnnotationsModule {}
