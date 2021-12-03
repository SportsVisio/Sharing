import { User } from './../../users/user.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { PassportStrategy } from '@nestjs/passport';
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { jwtConstants } from '../token/token.constants';
import { Repository } from "typeorm";
import { IDecodedToken } from "../token/token.interfaces";

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    @InjectRepository(User)
    public user: Repository<User>,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: jwtConstants.secret,
    });
  }

  validate({ userId }: IDecodedToken): Promise<User> {
    // translate to user entity
    return this.user.findOneOrFail(userId).catch(() => {
      throw new UnauthorizedException();
    });
  }
}