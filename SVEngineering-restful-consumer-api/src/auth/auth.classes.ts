import { User } from './../users/user.entity';
import { ApiProperty } from '@nestjs/swagger';
import { Request } from 'express';

export class AuthLoginInput {
  @ApiProperty({
    description: "Email address to log in with"
  })
  username: string;

  @ApiProperty()
  password: string;
}

export interface IAuthenticatedRequest extends Request {
  user: User;
}