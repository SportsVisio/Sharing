import { Index, OneToMany } from 'typeorm';
import { ScheduledGame } from './../scheduled-games/scheduled-game.entity';
import { SoftDeletableBaseEntity } from './../common/typeorm.classes';
import { Arena } from './arena.entity';
import { Entity, Column, ManyToOne } from 'typeorm';
import { MinLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

@Entity()
export class Court extends SoftDeletableBaseEntity {
  @Column({
    nullable: false
  })
  @Index({
    unique: false
  })
  @MinLength(3)
  @ApiProperty({
    description: "Publicly visible name of the court"
  })
  name: string;

  @ApiProperty({ type: () => Arena })
  @ManyToOne(() => Arena, arena => arena.courts)
  arena: Arena;

  @ApiProperty({ type: () => ScheduledGame })
  @OneToMany(() => ScheduledGame, game => game.court)
  game: ScheduledGame;
}