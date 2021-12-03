import { SoftDeletableBaseEntity } from './../common/typeorm.classes';
import { Entity, Column, OneToMany, Index, ManyToOne } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { AnnotationActorQualifier } from "./annotation-actor-qualifier.entity";
import { Annotation } from "./annotation.entity";
import { AnnotationAction } from "./annotation-action.entity";
import { TeamPlayer } from './../teams/team-player.entity';

export enum AnnotationActorTypes {
  PLAYER = "player",
  REFEREE = "referee",
  BALL = "ball",
  NET = "net",
  BACKBOARD = "backboard",
  SCOREBOARD = "scoreboard"
}

@Entity()
export class AnnotationActor extends SoftDeletableBaseEntity {
  @ApiProperty()
  @Column({
    nullable: false
  })
  @Index({
    unique: false
  })
  identifier: string;

  @ApiProperty()
  @Column({
    type: "enum",
    enum: AnnotationActorTypes,
    nullable: false
  })
  @Index({
    unique: false
  })
  type: string;

  @ApiProperty()
  @Column({
    nullable: false
  })
  @Index({
    unique: false
  })
  designation: string;

  @ApiProperty({ type: () => AnnotationActorQualifier, isArray: true })
  @OneToMany(() => AnnotationActorQualifier, q => q.actor, { cascade: true, eager: true })
  qualifiers: AnnotationActorQualifier[];

  @ApiProperty({ type: () => AnnotationAction, isArray: true })
  @OneToMany(() => AnnotationAction, action => action.actor, { cascade: true, eager: true })
  actions: AnnotationAction[];

  @ApiProperty({ type: () => Annotation })
  @ManyToOne(() => Annotation, annotation => annotation.actors)
  annotation: Annotation;

  @ApiProperty({ type: () => TeamPlayer })
  @ManyToOne(() => TeamPlayer, player => player.annotationActors, { eager: true })
  teamPlayer: TeamPlayer;
}