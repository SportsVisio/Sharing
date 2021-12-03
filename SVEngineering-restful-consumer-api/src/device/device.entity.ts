import { Account } from './../account/account.entity';
import { SoftDeletableBaseEntity } from './../common/typeorm.classes';
import { DeviceStream } from './device-stream.entity';
import { Entity, Column, Index, ManyToOne, OneToOne, OneToMany } from 'typeorm';
import { IsDefined, MinLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { DeviceScheduledGameAssn } from "./device-game-assn.entity";

@Entity()
export class Device extends SoftDeletableBaseEntity {
  @Column({
    nullable: false
  })
  @Index({ unique: true })
  @MinLength(5)
  @ApiProperty({
    description: "String identifier of the device to register. This can be a MAC address or any unique identifier for this device that is used to record.",
    example: "2C:54:91:88:C9:E3"
  })
  deviceId: string;

  @Column({
    nullable: false
  })
  @MinLength(5)
  @ApiProperty({
    description: "Friendly name of device for organization",
    example: "Left court camera"
  })
  name: string;

  @ApiProperty({ type: () => Account })
  @ManyToOne(() => Account, account => account.devices)
  account: Account;

  @ApiProperty({ type: () => DeviceStream })
  @OneToOne(() => DeviceStream, stream => stream.device, { cascade: true, eager: true })
  stream: DeviceStream;

  @ApiProperty({ type: () => DeviceScheduledGameAssn, isArray: true })
  @OneToMany(() => DeviceScheduledGameAssn, assn => assn.device)
  gameAssn: Promise<DeviceScheduledGameAssn[]>;  
}