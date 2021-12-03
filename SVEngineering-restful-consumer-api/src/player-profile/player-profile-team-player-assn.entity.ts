import { PlayerProfile } from './player-profile.entity';
import { ApiProperty } from '@nestjs/swagger';
import { CustomBaseEntity } from '../common/typeorm.classes';
import { Column, Entity, ManyToOne } from "typeorm";
import { TeamPlayer } from "../teams/team-player.entity";

@Entity()
export class PlayerProfileTeamPlayerAssn extends CustomBaseEntity {
  @ApiProperty()
  @Column({
    default: false
  })
  approved: boolean;

  @ApiProperty({ type: () => PlayerProfile })
  @ManyToOne(() => PlayerProfile, profile => profile.teamPlayerAssn)
  public profile!: PlayerProfile;

  @ApiProperty({ type: () => TeamPlayer })
  @ManyToOne(() => TeamPlayer, player => player.playerProfileAssn)
  public player!: TeamPlayer;
}