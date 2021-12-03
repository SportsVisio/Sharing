import { ApiProperty } from '@nestjs/swagger';
import { Entity, Column, ManyToOne, Index } from 'typeorm';
import { CustomBaseEntity } from "../common/typeorm.classes";
import { AnnotationActor } from "./annotation-actor.entity";

@Entity()
export class AnnotationActorQualifier extends CustomBaseEntity {
  @ApiProperty()
  @Column({
    nullable: false
  })
  @Index({
    unique: false
  })
  qualifier: string;

  @ApiProperty({ type: () => AnnotationActor })
  @ManyToOne(() => AnnotationActor, actor => actor.qualifiers)
  actor: AnnotationActor;
}