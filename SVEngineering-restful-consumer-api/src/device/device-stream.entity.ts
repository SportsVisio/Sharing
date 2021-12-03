import { SoftDeletableBaseEntity } from './../common/typeorm.classes';
import { Device } from './../device/device.entity';
import { Entity, Column, Index, OneToOne, JoinColumn } from 'typeorm';
import { IsDefined } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

// NOTE: these are long-lived / soft-deletable because they can relate to scheduled games
@Entity()
export class DeviceStream extends SoftDeletableBaseEntity {
  @Column({
    nullable: false
  })
  @Index({
    unique: false
  })
  @IsDefined()
  @ApiProperty({
    description: "Name of generated Kinesis Video stream"
  })
  streamName!: string;

  @ApiProperty({ type: () => Device })
  @OneToOne(() => Device, device => device.stream)
  @JoinColumn()
  device: Device;
}