import { Account } from 'src/account/account.entity';
import { ScheduledGame } from './../scheduled-games/scheduled-game.entity';
import { IAuthenticatedRequest } from './../auth/auth.classes';
import { ScheduledGameService } from './../scheduled-games/scheduled-game.service';
import { ScheduleGamePayload } from '../scheduled-games/scheduled-game.classes';
import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { SwaggerHeaderDefaults } from './../common/constants';
import { ApiTags, ApiBearerAuth, ApiHeader, ApiResponse, ApiOperation } from '@nestjs/swagger';
import { Controller, UseGuards, Post, Param, Body, Get, Delete, Request } from '@nestjs/common';
import { AcceptAccountInviteParams, AssignMemberRolePayload, AssignRoleParams, UnAssignRoleParams, InviteAccountMemberParams, InviteAccountMemberPayload, GetAccountParams } from "./account.classes";
import { AccountService } from "./account.service";

@Controller('account')
@ApiTags("Account")
export class AccountController {
  constructor(
    private accounts: AccountService,
    private games: ScheduledGameService
  ) { }

  @UseGuards(JwtAuthGuard)
  @Get(":accountId?")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: Account })
  @ApiResponse({ status: 404, description: 'User not found.' })
  public get(@Param() { accountId }: GetAccountParams, @Request() { user: { account } }: IAuthenticatedRequest): Promise<Account> {
    return this.accounts.get(accountId || account.id, {
      relations: ["teams", "members", "devices", "scheduledGames"]
    });
  }

  @UseGuards(JwtAuthGuard)
  @Post("invite/:accountId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: String })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  public invite(@Param() { accountId }: InviteAccountMemberParams, @Body() { email }: InviteAccountMemberPayload): Promise<boolean> {
    // future Dev - invite user to system if non-existent; error if user not found for now
    // future: email user / add without activating (3rd param below)
    return this.accounts.assignMember(accountId, email, true);
  }

  // @UseGuards(JwtAuthGuard)
  @Get("accept/:inviteId")
  // @ApiBearerAuth()
  // @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: String })
  @ApiResponse({ status: 404, description: 'Invite not found.' })
  public accept(@Param() { token }: AcceptAccountInviteParams): Promise<boolean> {
    return Promise.resolve(true);
  }

  @UseGuards(JwtAuthGuard)
  @Post("assign-role/:accountMemberRoleAssnId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: String })
  @ApiResponse({ status: 404, description: 'Member assignment not found.' })
  public assignRole(@Param() { accountMemberRoleAssnId }: AssignRoleParams, @Body() { role }: AssignMemberRolePayload): Promise<boolean> {
    return this.accounts.assignRole(accountMemberRoleAssnId, role);
  }

  @UseGuards(JwtAuthGuard)
  @Delete("unassign-role/:roleAssignmentId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: String })
  @ApiResponse({ status: 404, description: 'Member assignment not found.' })
  public unassignRole(@Param() { roleAssignmentId }: UnAssignRoleParams): Promise<boolean> {
    return this.accounts.unAssignRole(roleAssignmentId);
  }

  @UseGuards(JwtAuthGuard)
  @Post("games/schedule")
  @ApiBearerAuth()
  @ApiOperation({ deprecated: true })
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: () => ScheduledGame })
  public scheduleGame(@Body() { accountId, ...payload }: ScheduleGamePayload, @Request() { user }: IAuthenticatedRequest): Promise<ScheduledGame> {
    return this.games.create(accountId || user.account.id, payload);
  }
}
