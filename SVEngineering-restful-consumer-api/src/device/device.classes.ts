import { ApiProperty } from '@nestjs/swagger';
import { DevicePositions } from "./device-game-assn.entity";

export class GetDevicesParams {
  @ApiProperty({
    description: "Optional accountId to retrieve devices. If omitted, account of current user is used",
    required: false
  })
  accountId?: string;
}

export class GetDeviceParams {
  @ApiProperty({
    description: "Uuid of device"
  })
  deviceId?: string;
}

export class RegisterDevicePayload {
  @ApiProperty({
    description: "Optional accountId to retrieve devices. If omitted, account of current user is used",
    required: false
  })
  accountId?: string;

  @ApiProperty({
    description: "String device identifier for Device"
  })
  deviceId: string;

  @ApiProperty({
    description: "Friendly name of device for organization"
  })
  name: string;
}

export class UnregisterDeviceParams {
  @ApiProperty({
    description: "String uuid identifier for this device"
  })
  id: string;
}

export class UpdateDeviceScheduledGameParams {
  @ApiProperty({
    description: "Assignment uuid that connects device with game"
  })
  id: string;
}

export class UpdateDeviceScheduledGamePayload {
  @ApiProperty({
    description: "String identifier to use for video naming"
  })
  videoId: string;

  @ApiProperty({
    description: "Unix timestamp representing start of video capture timeframe"
  })
  startTime: number;

  @ApiProperty({
    description: "Unix timestamp representing the end of video capture timeframe"
  })
  endTime: number;

  @ApiProperty({
    description: "Position of camera on court"
  })
  position: DevicePositions;
}

export class AttachDeviceScheduledGamePayload extends UpdateDeviceScheduledGamePayload {
  @ApiProperty({
    description: "Device uuid identifier to attach"
  })
  deviceId: string;

  @ApiProperty({
    description: "Game uuid identifier to attach"
  })
  gameId: string;
}

export class DeviceStreamActionParams {
  @ApiProperty({
    description: "Device - Game Assignment uuid value"
  })
  id: string;
}