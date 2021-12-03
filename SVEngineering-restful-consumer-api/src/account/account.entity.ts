import { ScheduledGame } from '../scheduled-games/scheduled-game.entity';
import { User } from './../users/user.entity';
import { Entity, OneToOne, OneToMany, JoinColumn } from 'typeorm';
import { ApiProperty } from '@nestjs/swagger';
import { DeactivateableBaseEntity } from "../common/typeorm.classes";
import { Team } from "../teams/team.entity";
import { AccountMemberRoleAssn } from "./account-member-role-assn.entity";
import { Device } from "../device/device.entity";

@Entity()
export class Account extends DeactivateableBaseEntity {

  @ApiProperty({ type: () => User })
  @OneToOne(() => User, user => user.account)
  @JoinColumn()
  owner: User;

  @ApiProperty({ type: () => Team, isArray: true })
  @OneToMany(() => Team, team => team.account, { cascade: true })
  teams: Team[];

  @ApiProperty({ type: () => AccountMemberRoleAssn, isArray: true })
  @OneToMany(() => AccountMemberRoleAssn, assn => assn.account, { cascade: true })
  members: AccountMemberRoleAssn[];

  @ApiProperty({ type: () => Device, isArray: true })
  @OneToMany(() => Device, device => device.account, { cascade: true })
  devices: Device[];

  @ApiProperty({ type: () => ScheduledGame, isArray: true })
  @OneToMany(() => ScheduledGame, game => game.account, { cascade: true })
  scheduledGames: ScheduledGame[];
}