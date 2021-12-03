import { Court } from './court.entity';
import { Arena } from './arena.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { SharedModule } from '../shared/shared.module';
import { ArenaService } from "./arenas.service";
import { ArenasController } from "./arenas.controller";

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Arena,
      Court
    ]),
    SharedModule
  ],
  providers: [
    ArenaService
  ],
  exports: [
    TypeOrmModule,
    ArenaService
  ],
  controllers: [
    ArenasController
  ]
})
export class ArenasModule {}
