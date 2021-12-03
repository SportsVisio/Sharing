import { Index } from 'typeorm';
import { SoftDeletableBaseEntity } from './../common/typeorm.classes';
import { Court } from './court.entity';
import { Entity, Column, OneToMany } from 'typeorm';
import { MinLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

@Entity()
export class Arena extends SoftDeletableBaseEntity {
  @ApiProperty({
    description: "Publicly visible name of the arena"
  })
  @Column({
    nullable: false
  })
  @Index({ unique: true })
  @MinLength(5)
  name: string;

  @ApiProperty({ type: () => Court, isArray: true })
  @OneToMany(() => Court, court => court.arena, { cascade: true, eager: true })
  courts: Court[];
}