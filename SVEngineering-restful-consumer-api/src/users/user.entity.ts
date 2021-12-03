import { Exclude } from 'class-transformer';
import { Entity, Column, BeforeInsert, BeforeUpdate, OneToOne, OneToMany } from 'typeorm';
import { IsEmail, MinLength } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
import { SoftDeletableBaseEntity } from "../common/typeorm.classes";
import * as bcrypt from "bcryptjs";
import { Account } from "../account/account.entity";
import { AccountMemberRoleAssn } from "../account/account-member-role-assn.entity";
import { PlayerProfile } from "../player-profile/player-profile.entity";

@Entity()
export class User extends SoftDeletableBaseEntity {
  @Column({
    default: ""
  })
  @ApiProperty()
  firstName: string;

  @Column({
    default: ""
  })
  @ApiProperty()
  lastName: string;

  @Column({ unique: true })
  @IsEmail()
  @ApiProperty()
  email: string;

  // NOTE: Password / Salt a nullable so that in the future SSO can be implemented for Google, etc.
  @Column({
    nullable: true,
    default: null
  })
  @MinLength(5)
  @Exclude({ toPlainOnly: true })
  password?: string;

  @Column({
    nullable: true,
    default: null
  })
  @Exclude({ toPlainOnly: true })
  passwordSalt?: string;

  @Column({ default: false })
  @ApiProperty()
  inactive: boolean;

  @ApiProperty({ type: () => Account })
  @OneToOne(() => Account, account => account.owner, { cascade: true, eager: true })
  account: Account;

  @ApiProperty({ type: () => AccountMemberRoleAssn, isArray: true })
  @OneToMany(() => AccountMemberRoleAssn, assn => assn.user, { eager: true })
  accountRoleAssn: AccountMemberRoleAssn[];

  @ApiProperty({ type: () => PlayerProfile })
  @OneToOne(() => PlayerProfile, profile => profile.user, { cascade: true, eager: true })
  playerProfile: PlayerProfile;

  public static generatePasswordHash(plaintext: string, salt: string): string {
    return bcrypt.hashSync(plaintext, salt);
  }

  public static validatePassword(plaintext: string, hashed: string): boolean {
    return bcrypt.compareSync(plaintext, hashed);
  }

  @BeforeInsert()
  protected insertMutate(): void {
    this.password = this.generatePasswordHash();
  }

  @BeforeUpdate()
  protected updateMutate(): void {
    // if hashed passwords are different, the password is being updated here
    if (this.password && this.generatePasswordHash() !== this.password) {
      this.password = this.generatePasswordHash();
    }
  }

  public validatePassword(plaintext: string): boolean {
    return User.validatePassword(plaintext, this.password);
  }

  private generatePasswordHash() {
    if (!this.passwordSalt) this.passwordSalt = bcrypt.genSaltSync(5);
    return User.generatePasswordHash(this.password, this.passwordSalt);
  }
}