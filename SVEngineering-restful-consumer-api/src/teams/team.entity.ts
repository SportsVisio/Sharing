import { Account } from './../account/account.entity';
import { Entity, Column, OneToMany, ManyToMany, ManyToOne } from 'typeorm';
import { IsDefined, MinLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { SoftDeletableBaseEntity } from "../common/typeorm.classes";
import { TeamPlayer } from "./team-player.entity";
import { League } from "../leagues/league.entity";
import { TeamScheduledGameAssn } from "../scheduled-games/scheduled-game-team-assn.entity";

@Entity()
export class Team extends SoftDeletableBaseEntity {
  @Column({
    nullable: false
  })
  @MinLength(3)
  @ApiProperty({
    description: "Publicly visible name of the Team"
  })
  name: string;

  @Column({
    default: ""
  })
  @ApiProperty({
    description: "Url to profile image",
    required: false
  })
  imageUrl: string;

  @ApiProperty({ type: () => TeamPlayer, isArray: true })
  @OneToMany(() => TeamPlayer, player => player.team)
  players: TeamPlayer[];

  @ApiProperty({ type: () => League, isArray: true })
  @ManyToMany(() => League, league => league.teams)
  leagues: League[];

  @ApiProperty({ type: () => TeamScheduledGameAssn, isArray: true })
  @OneToMany(() => TeamScheduledGameAssn, assn => assn.team)
  teamGameAssn: TeamScheduledGameAssn[];

  @ApiProperty({ type: () => Account })
  @ManyToOne(() => Account, account => account.teams)
  account: Account;
}