import { User } from './../users/user.entity';
import { SoftDeletableBaseEntity } from './../common/typeorm.classes';
import { Entity, Column, OneToOne, JoinColumn, OneToMany } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { PlayerProfileTeamPlayerAssn } from "./player-profile-team-player-assn.entity";
import { PlayerProfileFollow } from "./player-profile-follow.entity";

@Entity()
export class PlayerProfile extends SoftDeletableBaseEntity {
  @Column({
    default: ""
  })
  @ApiProperty({
    description: "Player first name",
    required: false
  })
  firstName: string;
  
  @Column({
    default: ""
  })
  @ApiProperty({
    description: "Player last name",
    required: false
  })
  lastName: string;

  @Column({
    default: ""
  })
  @ApiProperty({
    description: "Url to profile image",
    required: false
  })
  imageUrl: string;

  @Column({
    default: ""
  })
  @ApiProperty({
    description: "Friendly nickname, optional",
    required: false
  })
  nickName: string;

  @ApiProperty({ type: () => User })
  @OneToOne(() => User, user => user.playerProfile)
  @JoinColumn()
  user: User;

  @OneToMany(() => PlayerProfileTeamPlayerAssn, assn => assn.profile, { cascade: true, eager: true })
  teamPlayerAssn: PlayerProfileTeamPlayerAssn[];

  @OneToMany(() => PlayerProfileFollow, profile => profile.follower, { eager: false })
  following: PlayerProfileFollow[];
  
  @OneToMany(() => PlayerProfileFollow, profile => profile.following, { eager: false })
  followers: PlayerProfileFollow[];
}