import { PlayerProfile } from './player-profile.entity';
import { User } from './../users/user.entity';
import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { SwaggerHeaderDefaults } from './../common/constants';
import { ApiTags, ApiBearerAuth, ApiHeader, ApiResponse, ApiConsumes, ApiBody } from '@nestjs/swagger';
import { Controller, UseGuards, Post, Param, Body, Get, Request, Put, Delete } from '@nestjs/common';
import { PlayerProfileService } from "./player-profile.service";
import { IAuthenticatedRequest } from "../auth/auth.classes";
import { ClaimTeamPlayerParams, FollowPlayerParams, GetPlayerProfileStatSummaryInput, GetPlayerProfileParams, SearchPlayerProfilesInput, UnfollowPlayerParams, UpdatePlayerProfileInput } from "./player-profile.classes";
import { PlayerStatSummary } from "../annotations/stats.classes";

@Controller('player-profiles')
@ApiTags("Player Profiles")
export class PlayerProfilesController {
  constructor(
    public profiles: PlayerProfileService
  ) { }

  @UseGuards(JwtAuthGuard)
  @Post("search")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: PlayerProfile })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  public search(@Body() { search }: SearchPlayerProfilesInput): Promise<PlayerProfile[]> {
    return this.profiles.search(search);
  }

  @UseGuards(JwtAuthGuard)
  @Post("stats")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: PlayerStatSummary })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  public stats(@Param() { profileId }: GetPlayerProfileParams, @Body() payload: GetPlayerProfileStatSummaryInput, @Request() { user: { playerProfile } }: IAuthenticatedRequest): Promise<PlayerStatSummary> {
    return this.profiles.getStats(profileId || playerProfile.id, payload);
  }

  @UseGuards(JwtAuthGuard)
  @Put(":profileId?")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: PlayerProfile })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  public update(@Body() { profileId, ...rest }: UpdatePlayerProfileInput, @Request() { user: { playerProfile } }: IAuthenticatedRequest): Promise<boolean> {
    return this.profiles.update(profileId || playerProfile.id, rest);
  }

  @UseGuards(JwtAuthGuard)
  @Get("following/:profileId?")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: PlayerProfile, isArray: true })
  public following(@Param() { profileId }: GetPlayerProfileParams, @Request() { user }: IAuthenticatedRequest): Promise<PlayerProfile[]> {
    return this.profiles.getFollowing(profileId || user.playerProfile.id);
  }

  @UseGuards(JwtAuthGuard)
  @Get(":profileId?")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: PlayerProfile, isArray: true })
  public get(@Param() { profileId }: GetPlayerProfileParams, @Request() { user: { playerProfile } }: IAuthenticatedRequest): Promise<PlayerProfile> {
    // TODO - check permissions if specifying userId
    return this.profiles.get(profileId || playerProfile.id, {
      relations: [
        "teamPlayerAssn", 
        "teamPlayerAssn.player",
        "teamPlayerAssn.player.team"
      ]
    });
  }

  @UseGuards(JwtAuthGuard)
  @Post("claim/:teamPlayerId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: PlayerProfile })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  public claim(@Param() { teamPlayerId }: ClaimTeamPlayerParams, @Request() { user: { playerProfile } }: IAuthenticatedRequest): Promise<boolean> {
    return this.profiles.claimTeamPlayer(teamPlayerId, playerProfile.id);
  }

  @UseGuards(JwtAuthGuard)
  @Post("follow/:profileId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: PlayerProfile })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  public follow(@Param() { profileId }: FollowPlayerParams, @Request() { user: { playerProfile } }: IAuthenticatedRequest): Promise<boolean> {
    return this.profiles.follow(profileId, playerProfile.id);
  }

  @UseGuards(JwtAuthGuard)
  @Delete("unfollow/:followId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Success', type: PlayerProfile })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  public unfollow(@Param() { followId }: UnfollowPlayerParams): Promise<boolean> {
    return this.profiles.unfollow(followId);
  }
}
