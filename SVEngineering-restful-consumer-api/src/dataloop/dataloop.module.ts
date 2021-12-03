import { SharedModule } from './../shared/shared.module';
import { Module } from '@nestjs/common';
import { DataloopController } from "./dataloop.controller";
import { DataloopService } from "./dataloop.service";
import { HttpModule, HttpService } from "@nestjs/axios";

@Module({
  imports: [
    SharedModule,
    HttpModule
  ],
  controllers: [DataloopController],
  providers: [
    DataloopService,
    HttpService
  ]
})
export class StreamsModule {}
