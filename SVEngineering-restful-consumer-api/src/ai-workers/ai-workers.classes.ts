import { Device } from './../device/device.entity';
import { IAiWorkerInstanceData } from './ai-workers.interfaces';
import { ApiProperty } from "@nestjs/swagger";

export class GetProcessVideoParams {
  @ApiProperty({
    description: "Scheduled game uuid"
  })
  scheduledGameId: string;
}

export class GetAiWorkerInstanceDataParams {
  @ApiProperty({
    description: "EC2 Instance Id"
  })
  ec2InstanceId: string;
}

export class DeviceFragmentDetail {
  @ApiProperty({
    description: "S3 location of stored Kinesis fragments for device"
  })
  s3Location: string;

  @ApiProperty({
    description: "Uuid of device-game assignment"
  })
  deviceGameAssnId: string;

  @ApiProperty({
    description: "Device record for Kinesys data",
    type: () => Device
  })
  device: Device;
}

export class AiWorkerInstanceData implements IAiWorkerInstanceData {
  @ApiProperty({
    description: "EC2 Instance Id"
  })
  instanceId: string;

  @ApiProperty({
    description: "Timestamp of last activity (used for garbage cleanup)"
  })
  lastAction: number;

  @ApiProperty({
    description: "If instance is available to process"
  })
  idle: boolean;

  @ApiProperty({
    description: "Has instance been set to terminate"
  })
  terminating: boolean;

  @ApiProperty({
    description: "Uuid of scheduled game to process"
  })
  scheduledGameId: string;

  @ApiProperty({
    description: "Presigned S3 folder urls for each assigned device video fragments",
    isArray: true
  })
  deviceVideoData: DeviceFragmentDetail[];
}