import { Index } from 'typeorm';
import { OneToMany } from 'typeorm';
import { ScheduledGame } from './../scheduled-games/scheduled-game.entity';
import { Entity, Column, ManyToMany, JoinTable } from 'typeorm';
import { MinLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { CustomBaseEntity } from "../common/typeorm.classes";
import { Team } from "../teams/team.entity";

@Entity()
export class League extends CustomBaseEntity {
  @Column({
    nullable: false
  })
  @MinLength(4)
  @Index({
    unique: true
  })
  @ApiProperty({
    description: "Publicly visible name of the league"
  })
  name: string;

  @ApiProperty({ type: () => Team, isArray: true })
  @ManyToMany(() => Team, team => team.leagues)
  @JoinTable()
  teams: Team[];

  @ApiProperty({ type: () => ScheduledGame })
  @OneToMany(() => ScheduledGame, game => game.league)
  game: ScheduledGame;
}