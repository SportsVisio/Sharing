import { Device } from './device.entity';
import { ApiProperty } from '@nestjs/swagger';
import { MinLength } from 'class-validator';
import { ScheduledGame } from '../scheduled-games/scheduled-game.entity';
import { SoftDeletableBaseEntity } from '../common/typeorm.classes';
import { Entity, Column, ManyToOne, Index } from "typeorm";

export enum DevicePositions {
  CENTER = "center",
  LEFT = "left",
  RIGHT = "right"
}

@Entity()
export class DeviceScheduledGameAssn extends SoftDeletableBaseEntity {
  @Column({
    nullable: false
  })
  @Index({
    unique: true
  })
  @MinLength(8)
  @ApiProperty({
    description: "String identifier to use for video naming, including extension",
    example: "some-file.mp4"
  })
  videoId!: string;

  @Column({
    default: false
  })
  @ApiProperty({
    description: "If the stream is currently set to process incoming fragments or not"
  })
  isActive: boolean;

  @Column({
    nullable: false
  })
  @ApiProperty({
    description: "Unix timestamp representing start of video capture timeframe",
    example: 1631216366
  })
  startTime: number;

  @Column({
    nullable: false
  })
  @ApiProperty({
    description: "Unix timestamp representing end of video capture timeframe",
    example: 1631216366
  })
  endTime: number;

  @Column({
    type: "enum",
    enum: DevicePositions,
    default: DevicePositions.CENTER
  })
  @Index({
    unique: false
  })
  @ApiProperty({
    description: "Position of camera on court"
  })
  position: string;

  @ApiProperty({ type: () => ScheduledGame })
  @ManyToOne(() => ScheduledGame, game => game.deviceGameAssn)
  public game!: ScheduledGame;

  @ApiProperty({ type: () => Device })
  @ManyToOne(() => Device, device => device.gameAssn, { eager: true })
  public device!: Device;
}