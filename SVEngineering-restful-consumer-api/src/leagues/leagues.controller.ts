import { GetLeagueParams, CreateLeaguePayload, UpdateLeaguePayload, UpdateLeagueParams } from './league.classes';
import { League } from './league.entity';
import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { SwaggerHeaderDefaults } from './../common/constants';
import { ApiTags, ApiBearerAuth, ApiHeader, ApiResponse, ApiBody } from '@nestjs/swagger';
import { Controller, UseGuards, Post, Param, Body, Get, Delete, Request, Put } from '@nestjs/common';
import { IAuthenticatedRequest } from "../auth/auth.classes";
import { LeagueService } from "./leagues.service";

@Controller('leagues')
@ApiTags("Leagues")
export class LeaguesController {
  constructor(
    public leagues: LeagueService
  ) { }

  @UseGuards(JwtAuthGuard)
  @Get("list")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: League, isArray: true })
  public getLeagues(): Promise<League[]> {
    return this.leagues.list();
  }

  @UseGuards(JwtAuthGuard)
  @Get(":leagueId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: League })
  @ApiResponse({ status: 404, description: 'League not found.' })
  public getLeague(@Param() { leagueId }: GetLeagueParams): Promise<League> {
    // TODO - permissions
    return this.leagues.get(leagueId, {
      relations: ["teams", "teams.players", "teams.teamGameAssn"]
    });
  }

  @UseGuards(JwtAuthGuard)
  @Post("")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => CreateLeaguePayload })
  @ApiResponse({ status: 200, description: 'Success.', type: League })
  public createLeague(@Body() payload: CreateLeaguePayload, @Request() { user }: IAuthenticatedRequest): Promise<League> {
    return this.leagues.create(payload);
  }

  @UseGuards(JwtAuthGuard)
  @Put(":leagueId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => UpdateLeaguePayload })
  @ApiResponse({ status: 200, description: 'Success.', type: Boolean })
  public updateLeague(@Param() { leagueId }: UpdateLeagueParams, @Body() payload: UpdateLeaguePayload, @Request() { user }: IAuthenticatedRequest): Promise<boolean> {
    // TODO - permissions check
    return this.leagues.update(leagueId, payload);
  }

  @UseGuards(JwtAuthGuard)
  @Delete(":leagueId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: League })
  @ApiResponse({ status: 404, description: 'League not found.' })
  public delete(@Param() { leagueId }: GetLeagueParams): Promise<boolean> {
    // TODO - permissions
    return this.leagues.delete(leagueId);
  }

}
