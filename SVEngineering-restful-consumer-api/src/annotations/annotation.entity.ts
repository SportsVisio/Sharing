import { ScheduledGame } from './../scheduled-games/scheduled-game.entity';
import { IsDefined } from 'class-validator';
import { DeviceScheduledGameAssn } from './../device/device-game-assn.entity';
import { SoftDeletableBaseEntity } from './../common/typeorm.classes';
import { Entity, Column, OneToMany, Index, ManyToOne } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { AnnotationAction } from "./annotation-action.entity";
import { AnnotationActor } from "./annotation-actor.entity";

export enum AnnotationSources {
  AI = "ai",
  MANUAL = "manual"
}

@Entity()
export class Annotation extends SoftDeletableBaseEntity {
  @ApiProperty({
    description: "Source of annotation; either AI or Manual"
  })
  @Column({
    type: "enum",
    enum: AnnotationSources,
    default: AnnotationSources.AI,
    nullable: false
  })
  @Index({
    unique: false
  })
  source: string;

  @Column()
  @ApiProperty({
    description: "ETag identifier for S3-stored annotation JSON output",
    nullable: false
  })
  s3ETag: string;

  @Column({
    nullable: false
  })
  @ApiProperty({
    description: "Name of video file that was annotated"
  })
  @Index({
    unique: false
  })
  videoName: string;

  @Column({
    nullable: false
  })
  @ApiProperty()
  @Index({
    unique: false
  })
  inputType: string;

  @Column({
    nullable: false
  })
  @ApiProperty()
  frameResolution: string;

  @Column({
    nullable: false
  })
  @ApiProperty()
  frameRate: number;

  @Column({
    nullable: false
  })
  @ApiProperty()
  frameSkip: number;

  @Column({
    nullable: false
  })
  @ApiProperty()
  processingWindowSize: number;
  
  @Column({
    nullable: false
  })
  @ApiProperty()
  processingWindowOverlap: number;

  @ApiProperty({ type: () => AnnotationAction, isArray: true })
  @OneToMany(() => AnnotationAction, action => action.annotation, { cascade: true, eager: true })
  actions: AnnotationAction[];

  @ApiProperty({ type: () => AnnotationActor, isArray: true })
  @OneToMany(() => AnnotationActor, actor => actor.annotation, { cascade: true, eager: true })
  actors: AnnotationActor[];

  @ApiProperty({ type: () => ScheduledGame })
  @IsDefined()
  @ManyToOne(() => ScheduledGame, game => game.annotations)
  scheduledGame: ScheduledGame;
}