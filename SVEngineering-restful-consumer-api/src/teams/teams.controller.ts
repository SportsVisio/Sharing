import { GetTeamParams, CreateTeamPayload, UpdateTeamPayload, UpdateTeamParams, GetTeamsParams, CreateTeamPlayerPayload, CreateTeamPlayerParams, UpdateTeamPlayerParams, UpdateTeamPlayerPayload, SearchTeamsInput } from './team.classes';
import { Team } from './team.entity';
import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { SwaggerHeaderDefaults } from './../common/constants';
import { ApiTags, ApiBearerAuth, ApiHeader, ApiResponse, ApiBody } from '@nestjs/swagger';
import { Controller, UseGuards, Post, Param, Body, Get, Request, Put } from '@nestjs/common';
import { IAuthenticatedRequest } from "../auth/auth.classes";
import { TeamService } from "./teams.service";

@Controller('teams')
@ApiTags("Teams")
export class TeamsController {
  constructor(
    public teams: TeamService
  ) { }

  @UseGuards(JwtAuthGuard)
  @Post("search")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: Team })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  public search(@Body() { search }: SearchTeamsInput): Promise<Team[]> {
    return this.teams.search(search);
  }

  @UseGuards(JwtAuthGuard)
  @Get("list/:accountId?")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: Team, isArray: true })
  public getTeams(@Param() { accountId }: GetTeamsParams, @Request() { user }: IAuthenticatedRequest): Promise<Team[]> {
    return this.teams.list(accountId || user.account.id);
  }

  @UseGuards(JwtAuthGuard)
  @Get(":teamId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success.', type: Team })
  @ApiResponse({ status: 404, description: 'Team not found.' })
  public getTeam(@Param() { teamId }: GetTeamParams): Promise<Team> {
    // TODO - permissions
    return this.teams.get(teamId, {
      relations: ["players", "leagues","teamGameAssn"]
    });
  }

  @UseGuards(JwtAuthGuard)
  @Post("")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => CreateTeamPayload })
  @ApiResponse({ status: 200, description: 'Success.', type: Team })
  public createTeam(@Body() payload: CreateTeamPayload, @Request() { user }: IAuthenticatedRequest): Promise<Team> {
    return this.teams.create(user.account.id, payload);
  }

  @UseGuards(JwtAuthGuard)
  @Put(":teamId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => UpdateTeamPayload })
  @ApiResponse({ status: 200, description: 'Success.', type: Boolean })
  public updateTeam(@Param() { teamId }: UpdateTeamParams, @Body() payload: UpdateTeamPayload, @Request() { user }: IAuthenticatedRequest): Promise<boolean> {
    // TODO - permissions check
    return this.teams.update(teamId, payload);
  }

  @UseGuards(JwtAuthGuard)
  @Post("players/:teamId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => CreateTeamPlayerPayload })
  @ApiResponse({ status: 200, description: 'Success.', type: Boolean })
  public createPlayer(@Param() { teamId }: CreateTeamPlayerParams, @Body() payload: CreateTeamPlayerPayload, @Request() { user }: IAuthenticatedRequest): Promise<boolean> {
    // TODO - check permissions
    return this.teams.createPlayer(teamId, payload).then(() => true);
  }

  @UseGuards(JwtAuthGuard)
  @Put("players/:teamPlayerId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => UpdateTeamPlayerPayload })
  @ApiResponse({ status: 200, description: 'Success.', type: Boolean })
  public updatePlayer(@Param() { teamPlayerId }: UpdateTeamPlayerParams, @Body() payload: UpdateTeamPlayerPayload, @Request() { user }: IAuthenticatedRequest): Promise<boolean> {
    // TODO - check permissions
    return this.teams.updatePlayer(teamPlayerId, payload);
  }

}
