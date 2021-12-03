import { AccountModule } from './../account/account.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from './user.entity';
import { forwardRef, Module } from '@nestjs/common';
import { UserService } from './users.service';
import { UsersController } from './users.controller';
import { SharedModule } from '../shared/shared.module';
import { PlayerProfileModule } from "../player-profile/player-profile.module";

@Module({
  imports: [
    forwardRef(() => AccountModule),
    TypeOrmModule.forFeature([
      User
    ]),
    SharedModule,
    PlayerProfileModule
  ],
  providers: [UserService],
  exports: [
    TypeOrmModule,
    UserService,
    PlayerProfileModule
  ],
  controllers: [UsersController]
})
export class UsersModule {}
