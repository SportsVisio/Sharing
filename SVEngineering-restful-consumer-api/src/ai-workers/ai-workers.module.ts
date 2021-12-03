import { Module } from '@nestjs/common';
import { ScheduledGamesModule } from "../scheduled-games/scheduled-game.module";
import { SharedModule } from '../shared/shared.module';
import { AiWorkersController } from "./ai-workers.controller";
import { AiWorkerService } from "./ai-workers.service";

@Module({
  imports: [
    SharedModule,
    ScheduledGamesModule
  ],
  providers: [
    AiWorkerService
  ],
  exports: [
    AiWorkerService
  ],
  controllers: [
    AiWorkersController
  ]
})
export class AiWorkersModule { }

