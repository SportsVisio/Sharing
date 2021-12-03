import { AiWorkersModule } from './ai-workers/ai-workers.module';
import { UploadModule } from './upload/upload.module';
import { ArenasModule } from './arenas/arenas.module';
import { LeaguesModule } from './leagues/leagues.module';
import { PlayerProfileModule } from './player-profile/player-profile.module';
import { DevicesModule } from './device/device.module';
import { AccountModule } from './account/account.module';
import { AuthModule } from './auth/auth.module';
import { Module } from '@nestjs/common';
import { VideoModule } from "./video/video.module";
import { HighlightsModule } from "./highlights/highlights.module";
import { SharedModule } from "./shared/shared.module";
import { TypeOrmModule } from "@nestjs/typeorm";
import { TypeOrmConfigFactory } from "./common/typeorm.classes";
import { SendGridModule } from "@anchan828/nest-sendgrid";
import { TeamsModule } from "./teams/teams.module";
import { ScheduledGamesModule } from "./scheduled-games/scheduled-game.module";
import { AnnotationsModule } from "./annotations/annotations.module";

@Module({
  imports: [
    AuthModule,
    SharedModule, 
    TypeOrmModule.forRoot(TypeOrmConfigFactory()),
    SendGridModule.forRoot({
      apikey: process.env.SENDGRID_API_KEY,
    }),
    AccountModule,
    ArenasModule,
    AnnotationsModule,
    LeaguesModule,
    TeamsModule,
    DevicesModule,
    VideoModule, 
    HighlightsModule,
    ScheduledGamesModule,
    PlayerProfileModule,
    UploadModule,
    AiWorkersModule
  ],
  exports: [
    SharedModule
  ],
  controllers: [],
  providers: [],
})
export class AppModule { }