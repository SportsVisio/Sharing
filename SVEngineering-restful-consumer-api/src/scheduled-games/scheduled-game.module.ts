import { ScheduledGamesController } from './scheduled-games.controller';
import { TeamScheduledGameAssn } from './scheduled-game-team-assn.entity';
import { ScheduledGame } from './scheduled-game.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ScheduledGameService } from './scheduled-game.service';
import { Module } from '@nestjs/common';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      ScheduledGame,
      TeamScheduledGameAssn
    ])
  ],
  providers: [ScheduledGameService],
  exports: [
    ScheduledGameService,
    TypeOrmModule
  ],
  controllers: [
    ScheduledGamesController
  ]
})
export class ScheduledGamesModule { }
