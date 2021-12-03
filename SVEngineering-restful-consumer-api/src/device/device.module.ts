import { DeviceStream } from './device-stream.entity';
import { DevicesService } from './device.service';
import { DevicesController } from './device.controller';
import { Device } from './device.entity';
import { AccountModule } from './../account/account.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { forwardRef, Module } from '@nestjs/common';
import { SharedModule } from '../shared/shared.module';
import { DeviceScheduledGameAssn } from "./device-game-assn.entity";
import { ScheduledGamesModule } from "../scheduled-games/scheduled-game.module";

@Module({
  imports: [
    forwardRef(() => AccountModule),
    TypeOrmModule.forFeature([
      Device,
      DeviceStream,
      DeviceScheduledGameAssn
    ]),
    ScheduledGamesModule,
    SharedModule
  ],
  providers: [
    DevicesService
  ],
  exports: [
    TypeOrmModule,
    DevicesService
  ],
  controllers: [DevicesController]
})
export class DevicesModule {}
