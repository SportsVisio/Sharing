import { ApiProperty } from '@nestjs/swagger';
import { User } from './../users/user.entity';
import { CustomBaseEntity } from './../common/typeorm.classes';
import { Column, Entity, ManyToOne, OneToMany } from "typeorm";
import { Account } from "./account.entity";
import { AccountMemberRole } from "./account-member-role.entity";

@Entity()
export class AccountMemberRoleAssn extends CustomBaseEntity {
  @ApiProperty()
  @Column({
    default: false
  })
  accepted: boolean;

  @ApiProperty({ type: () => User })
  @ManyToOne(() => User, user => user.accountRoleAssn)
  public user!: User;

  @ApiProperty({ type: () => Account })
  @ManyToOne(() => Account, account => account.members)
  public account!: Account;

  @ApiProperty({ type: () => AccountMemberRole, isArray: true })
  @OneToMany(() => AccountMemberRole, role => role.accountMemberAssn, { eager: true })
  public roles: AccountMemberRole[];
}