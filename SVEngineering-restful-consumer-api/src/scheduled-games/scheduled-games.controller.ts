import { ScheduledGameService } from './scheduled-game.service';
import { ScheduledGame } from './scheduled-game.entity';
import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { SwaggerHeaderDefaults } from './../common/constants';
import { ApiTags, ApiBearerAuth, ApiHeader, ApiResponse, ApiBody } from '@nestjs/swagger';
import { Controller, UseGuards, Post, Param, Body, Get, Request, Put } from '@nestjs/common';
import { IAuthenticatedRequest } from "../auth/auth.classes";
import { GetScheduledGameParams, GetScheduledGamesParams, ScheduleGamePayload, UpdateScheduledGameParams, UpdateScheduledGamePayload } from "./scheduled-game.classes";

@Controller('scheduled-games')
@ApiTags("Scheduled Games")
export class ScheduledGamesController {
  constructor(
    public games: ScheduledGameService
  ) { }

  @UseGuards(JwtAuthGuard)
  @Get("list/:accountId?")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: ScheduledGame, isArray: true })
  public getLeagues(@Param() { accountId }: GetScheduledGamesParams, @Request() { user }: IAuthenticatedRequest): Promise<ScheduledGame[]> {
    return this.games.list(accountId || user.account.id, {
      relations: ["league", "court"]
    });
  }

  @UseGuards(JwtAuthGuard)
  @Get(":scheduledGameId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: ScheduledGame })
  @ApiResponse({ status: 404, description: 'League not found.' })
  public getLeague(@Param() { scheduledGameId }: GetScheduledGameParams): Promise<ScheduledGame> {
    // TODO - permissions
    return this.games.get(scheduledGameId, {
      relations: ["league", "court", "annotations", "account"]
    });
  }

  @UseGuards(JwtAuthGuard)
  @Post("")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => ScheduleGamePayload })
  @ApiResponse({ status: 200, description: 'Success.', type: ScheduledGame })
  public scheduleGame(@Body() { accountId, ...payload }: ScheduleGamePayload, @Request() { user }: IAuthenticatedRequest): Promise<ScheduledGame> {
    return this.games.create(accountId || user.account.id, payload);
  }

  @UseGuards(JwtAuthGuard)
  @Put(":scheduledGameId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => UpdateScheduledGamePayload })
  @ApiResponse({ status: 200, description: 'Success.', type: Boolean })
  public updateLeague(@Param() { scheduledGameId }: UpdateScheduledGameParams, @Body() payload: UpdateScheduledGamePayload, @Request() { user }: IAuthenticatedRequest): Promise<boolean> {
    // TODO - permissions check
    return this.games.update(scheduledGameId, payload);
  }

}
