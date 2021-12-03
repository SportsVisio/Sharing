import { SwaggerHeaderDefaults } from './../common/constants';
import { JwtAuthGuard } from './passport/jwt.auth-guard';
import { AuthLoginInput, IAuthenticatedRequest } from './auth.classes';
import { TokenService } from './token/token.service';
import { Controller, Post, Get, Request, UseGuards } from '@nestjs/common';
import { LocalAuthGuard } from "./passport/local-auth.guard";
import { TokenResponse } from "./token/token.classes";
import { ApiResponse, ApiBearerAuth, ApiHeader, ApiTags, ApiBody } from '@nestjs/swagger';

@Controller('auth')
@ApiTags("Authentication")
export class AuthController {
  constructor(
    private token: TokenService
  ) { }

  @UseGuards(LocalAuthGuard)
  @Post("login")
  @ApiResponse({ status: 200, description: 'Login successful.', type: TokenResponse })
  @ApiResponse({ status: 403, description: 'Forbidden / failure.' })
  @ApiBody({ type: () => AuthLoginInput })
  public login(@Request() req: IAuthenticatedRequest): TokenResponse {
    return this.token.sign({...req.user, userId: req.user.id});
  }

  @UseGuards(JwtAuthGuard)
  @Get("exchange")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: TokenResponse })
  @ApiResponse({ status: 403, description: 'Failure.' })
  public exchange(@Request() req: Request): TokenResponse {
    const {
      Authorization,
      authorization
    } = req.headers as any;

    return this.token.exchange(Authorization || authorization);
  }
}
