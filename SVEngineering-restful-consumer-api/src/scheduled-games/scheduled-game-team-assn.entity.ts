import { ScheduledGame } from './scheduled-game.entity';
import { CustomBaseEntity } from '../common/typeorm.classes';
import { Entity, Column, ManyToOne } from "typeorm";
import { Team } from "../teams/team.entity";
import { ApiProperty } from "@nestjs/swagger";

@Entity()
export class TeamScheduledGameAssn extends CustomBaseEntity {
  @Column({
    nullable: false    
  })
  @ApiProperty({
    description: "Designation of this team, for this game",
    example: "Home / Away / Team1 / Team 2 / etc."
  })
  public designation!: string;

  @Column({
    nullable: false
  })
  @ApiProperty({
    description: "Primary base color designation for this team",
    example: "Red"
  })
  public color: string;

  @ApiProperty({ type: () => Team })
  @ManyToOne(() => Team, team => team.teamGameAssn, { eager: true })
  public team: Team;

  @ApiProperty({ type: () => ScheduledGame })
  @ManyToOne(() => ScheduledGame, game => game.teamGameAssn)
  public game: ScheduledGame;
}