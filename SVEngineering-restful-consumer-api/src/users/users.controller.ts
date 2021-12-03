import { SwaggerHeaderDefaults } from './../common/constants';
import { jwtConstants } from './../auth/token/token.constants';
import { User } from './user.entity';
import { JwtAuthGuard } from '../auth/passport/jwt.auth-guard';
import { UserService } from './users.service';
import { Controller, Get, Param, Post, UseGuards, Body, Put, Request } from '@nestjs/common';
import { GetUserParams, UserSignupInput, UserActivateInput, UserUpdateInput, UserForgotPasswordInput } from "./user.classes";
import { ApiResponse, ApiBearerAuth, ApiHeader, ApiTags, ApiConsumes, ApiBody } from '@nestjs/swagger';
import { IAuthenticatedRequest } from "../auth/auth.classes";

@Controller('users')
@ApiTags("Users")
export class UsersController {
  constructor(
    private users: UserService,
  ) { }

  @UseGuards(JwtAuthGuard)
  @Get(":id?")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'User found.', type: User })
  @ApiResponse({ status: 404, description: 'User not found.' })
  public getUser(@Param() { userId }: GetUserParams, @Request() { user }: IAuthenticatedRequest): Promise<User> {
    return this.users.get(userId || user.id);
  }

  @Post("signup")
  @ApiResponse({ status: 200, description: 'Signup successful.', type: User })
  @ApiResponse({ status: 400, description: "Malformed request" })
  @ApiBody({ type: () => UserSignupInput })
  public async signup(@Body() input: UserSignupInput): Promise<User> {
    return this.users.signup(input);
  }

  @Post("recover")
  @ApiResponse({ status: 200, description: 'Success.', type: User })
  @ApiResponse({ status: 400, description: "Malformed request" })
  @ApiBody({ type: () => UserForgotPasswordInput })
  public async recover(@Body() { email }: UserForgotPasswordInput): Promise<boolean> {
    return this.users.recover(email);
  }

  // NOTE: for future use when email / token verification is needed
  @Put("activate")
  @ApiResponse({ status: 200, description: 'Activation successful.', type: User })
  @ApiBody({ type: () => UserActivateInput })
  public async activate(@Body() input: UserActivateInput): Promise<User> {
    return this.users.activate(input);
  }

  @UseGuards(JwtAuthGuard)
  @Put(":userId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => UserUpdateInput })
  @ApiResponse({ status: 200, description: 'Update successful.', type: User })
  public async update(@Param() { userId }: GetUserParams, @Body() input: UserUpdateInput, @Request() { user }: IAuthenticatedRequest): Promise<User> {
    // TODO - permission check if specifying userId
    return this.users.update(userId || user.id, input);
  }
}
