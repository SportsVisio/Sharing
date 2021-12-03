import { jwtConstants } from './token.constants';
import { ITokenPayload, ITokenResponse } from './token.interfaces';
import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as ms from "ms";

@Injectable()
export class TokenService {
  constructor(
    private jwtService: JwtService
  ) {}

  public sign({ userId, firstName, lastName }: ITokenPayload): ITokenResponse {
    const issued = new Date().getTime();
    const payload = { userId };

    return { 
      firstName,
      lastName,
      userId,
      issued,
      expires: issued + ms(jwtConstants.expiration),
      token: this.jwtService.sign(payload)
    };
  }

  public exchange(token: string): ITokenResponse {
    if (token.startsWith("Bearer")) token = token.split(" ")[1];
    
    // this will throw an error if the token itself is invalid, or the expiration has lapsed
    const payload = this.jwtService.verify(token, { secret: jwtConstants.secret }) as ITokenPayload;

    // re-sign
    return this.sign(payload);
  }
}
