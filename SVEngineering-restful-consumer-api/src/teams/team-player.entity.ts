import { AnnotationActor } from './../annotations/annotation-actor.entity';
import { Entity, Column, OneToMany, ManyToOne } from 'typeorm';
import { IsDefined, MinLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { SoftDeletableBaseEntity } from "../common/typeorm.classes";
import { Team } from "./team.entity";
import { PlayerProfileTeamPlayerAssn } from "../player-profile/player-profile-team-player-assn.entity";

@Entity()
export class TeamPlayer extends SoftDeletableBaseEntity {
  @Column({
    nullable: false
  })
  @MinLength(3)
  @ApiProperty({
    description: "Publicly visible name of the player"
  })
  name: string;

  @Column({
    nullable: false
  })
  @MinLength(1)
  @ApiProperty({
    description: "Jersey number or identification of player"
  })
  number: string;

  @ApiProperty({ type: () => Team })
  @ManyToOne(() => Team, team => team.players)
  team: Team;

  @ApiProperty({ type: () => PlayerProfileTeamPlayerAssn, isArray: true })
  @OneToMany(() => PlayerProfileTeamPlayerAssn, assn => assn.player)
  playerProfileAssn: PlayerProfileTeamPlayerAssn[];

  @ApiProperty({ type: () => AnnotationActor, isArray: true })
  @OneToMany(() => AnnotationActor, actor => actor.teamPlayer)
  annotationActors: AnnotationActor[];
}