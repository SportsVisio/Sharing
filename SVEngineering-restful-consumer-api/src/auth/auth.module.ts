import { jwtConstants } from './token/token.constants';
import { UsersModule } from './../users/users.module';
import { LocalStrategy } from './passport/local.strategy';
import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { PassportModule } from '@nestjs/passport';
import { AuthController } from './auth.controller';
import { JwtModule } from '@nestjs/jwt';
import { JwtStrategy } from "./passport/jwt.strategy";
import { TokenService } from './token/token.service';

@Module({
  imports: [
    UsersModule,
    PassportModule.register({
      defaultStrategy: "jwt"
    }),
    JwtModule.register({
      secret: jwtConstants.secret,
      signOptions: { 
        expiresIn: jwtConstants.expiration
      },
    }),
  ],
  providers: [
    AuthService,
    LocalStrategy,
    JwtStrategy,
    TokenService
  ],
  controllers: [
    AuthController
  ],
  exports: [
    AuthService
  ]
})
export class AuthModule { }
