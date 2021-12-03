import { PlayerProfile } from './player-profile.entity';
import { ApiProperty } from '@nestjs/swagger';
import { CustomBaseEntity } from '../common/typeorm.classes';
import { Column, Entity, ManyToOne } from "typeorm";

@Entity()
export class PlayerProfileFollow extends CustomBaseEntity {
  @ApiProperty({ type: () => PlayerProfile })
  @ManyToOne(() => PlayerProfile, profile => profile.followers)
  public follower!: PlayerProfile;

  @ApiProperty({ type: () => PlayerProfile })
  @ManyToOne(() => PlayerProfile, profile => profile.following)
  public following!: PlayerProfile;
}