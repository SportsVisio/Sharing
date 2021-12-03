import { AnnotationActor } from './annotation-actor.entity';
import { SoftDeletableBaseEntity } from './../common/typeorm.classes';
import { Entity, Column, OneToMany, ManyToOne, Index } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { AnnotationActionQualifier } from "./annotation-action-qualifier.entity";
import { Annotation } from "./annotation.entity";

export enum AnnotationActions {
  JUMP_BALL = "jump-ball",
  FIELD_GOAL = "field-goal",
  FREE_THROW = "free-throw",
  REBOUND = "rebound",
  ASSIST_2 = "assist-2",
  UNKNOWN = "uknown"
}

@Entity()
export class AnnotationAction extends SoftDeletableBaseEntity {
  @ApiProperty()
  @Column({
    type: "enum",
    enum: AnnotationActions,
    nullable: false
  })
  @Index({
    unique: false
  })
  action: string;

  @ApiProperty()
  @Column({
    nullable: false
  })
  startTime: string;

  @ApiProperty()
  @Column({
    nullable: false
  })
  startFrame: number;

  @ApiProperty()
  @Column("decimal", { precision: 2, scale: 2, nullable: false })
  confidence: number;

  @ApiProperty()
  @Column({
    nullable: false
  })
  location: string;

  @ApiProperty({ type: () => AnnotationActionQualifier, isArray: true })
  @OneToMany(() => AnnotationActionQualifier, q => q.action, { cascade: true, eager: true })
  qualifiers: AnnotationActionQualifier[];

  @ApiProperty({ type: () => Annotation })
  @ManyToOne(() => Annotation, annotation => annotation.actions)
  annotation: Annotation;

  @ApiProperty({ type: () => AnnotationActor })
  @ManyToOne(() => AnnotationActor, actor => actor.actions)
  actor: AnnotationActor;
}