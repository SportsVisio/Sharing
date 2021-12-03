import { ApiProperty } from '@nestjs/swagger';
import { Entity, Column, ManyToOne, Index } from 'typeorm';
import { IsDefined } from 'class-validator';
import { CustomBaseEntity } from "../common/typeorm.classes";
import { AnnotationAction } from "./annotation-action.entity";

export enum AnnotationActionQualifiers {
  TWO_POINT = "2-point",
  THREE_POINT = "3-point",
  MADE = "made",
  MISS = "miss",
  OFFENSIVE = "offensive",
  DEFENSIVE = "defensive",
  UNKNOWN = "unknown",
}

@Entity()
export class AnnotationActionQualifier extends CustomBaseEntity {
  @ApiProperty()
  @Column({
    type: "enum",
    enum: AnnotationActionQualifiers,
    nullable: false
  })
  @Index({
    unique: false
  })
  qualifier: string;

  @ApiProperty({ type: () => AnnotationAction })
  @Index({
    unique: false,
  })
  @ManyToOne(() => AnnotationAction, action => action.qualifiers)
  action: AnnotationAction;
}