import { AccountMemberRoleAssn } from './account-member-role-assn.entity';
import { AccountMemberRole, AccountMemberRoles } from './account-member-role.entity';
import { UserService } from './../users/users.service';
import { Account } from './account.entity';
import { logger } from './../common/logger';
import { Injectable } from '@nestjs/common';
import { FindManyOptions, Repository } from 'typeorm';
import { InjectRepository } from "@nestjs/typeorm";
import { PromisedNotFoundException } from "../common/constants";

@Injectable()
export class AccountService {
  constructor(
    @InjectRepository(Account)
    public accounts: Repository<Account>,
    @InjectRepository(AccountMemberRoleAssn)
    public assignments: Repository<AccountMemberRoleAssn>,
    @InjectRepository(AccountMemberRole)
    public roles: Repository<AccountMemberRole>,
    private users: UserService
  ) { }

  public get(accountId: string, options?: Partial<FindManyOptions<Account>>): Promise<Account> {
    return this.accounts.findOneOrFail(accountId, options).catch(PromisedNotFoundException);
  }

  public async assignMember(accountId: string, email: string, activate = false): Promise<boolean> {
    const user = await this.users.findByEmail(email);
    // TODO - determine if user already exists
    return this.accounts.findOneOrFail(accountId).catch(PromisedNotFoundException).then(async account => {
      const members = await account.members;
      account.members = [
        ...members,
        this.assignments.create({
          user,
          accepted: activate
        })
      ];

      return account.save();
    }).then(() => true).catch(err => {
      logger.error(err);
      return false;
    });
  }

  public async assignRole(memberAssnId: string, role: AccountMemberRoles): Promise<boolean> {
    const assn = await this.assignments.findOneOrFail(memberAssnId).catch(PromisedNotFoundException);
    // TODO - check if they're already assigned this role
    return this.roles.create({
      accountMemberAssn: assn,
      role
    }).save().then(() => true).catch(err => {
      logger.error(err);
      return false;
    });
  }

  public async unAssignRole(roleAssnId: string): Promise<boolean> {
    const assn = await this.roles.findOneOrFail(roleAssnId).catch(PromisedNotFoundException);
    return assn.remove().then(() => true).catch(err => {
      logger.error(err);
      return false;
    });
  }
}
