import { ApiProperty } from '@nestjs/swagger';
import { Entity, Column, ManyToOne } from 'typeorm';
import { IsDefined } from 'class-validator';
import { CustomBaseEntity } from "../common/typeorm.classes";
import { AccountMemberRoleAssn } from "./account-member-role-assn.entity";

export enum AccountMemberRoles {
  OWNER = "owner",
  LEAGUE_ADMIN = "leagueAdmin",
  TEAM_ADMIN = "teamAdmin"
}

@Entity()
export class AccountMemberRole extends CustomBaseEntity {
  @ApiProperty()
  @Column({
    type: "enum",
    enum: AccountMemberRoles,
    nullable: false
  })
  role: string;

  @ApiProperty({ type: () => AccountMemberRoleAssn })
  @ManyToOne(() => AccountMemberRoleAssn, assn => assn.roles)
  accountMemberAssn: AccountMemberRoleAssn;
}