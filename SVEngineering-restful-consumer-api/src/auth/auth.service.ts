import { UserService } from './../users/users.service';
import { Injectable } from '@nestjs/common';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UserService,
  ) { }

  public async validateUser(username: string, pass: string): Promise<any> {
    const user = await this.usersService.findByEmail(username);

    if (user && !user.validatePassword(pass)) return null;

    return user;
  }
}
