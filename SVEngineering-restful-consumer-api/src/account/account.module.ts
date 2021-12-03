import { UsersModule } from './../users/users.module';
import { AccountMemberRoleAssn } from './account-member-role-assn.entity';
import { UserService } from './../users/users.service';
import { AccountController } from './account.controller';
import { Account } from './account.entity';
import { SharedModule } from './../shared/shared.module';
import { forwardRef, Module } from '@nestjs/common';
import { TypeOrmModule } from "@nestjs/typeorm";
import { AccountService } from "./account.service";
import { AccountMemberRole } from "./account-member-role.entity";
import { ScheduledGamesModule } from "../scheduled-games/scheduled-game.module";

@Module({
  imports: [
    forwardRef(() => UsersModule),
    TypeOrmModule.forFeature([
      Account,
      AccountMemberRole,
      AccountMemberRoleAssn,
    ]),
    ScheduledGamesModule,
    SharedModule,
  ],
  controllers: [AccountController],
  providers: [
    AccountService,
    UserService
  ],
  exports: [
    TypeOrmModule
  ]
})
export class AccountModule {}
