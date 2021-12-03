import { ApiProperty } from '@nestjs/swagger';
import { AnnotationSources } from "../annotations/annotation.entity";

export class GetPlayerProfileParams {
  @ApiProperty({
    description: "Optional profileId to retrieve. If omitted, profile of current user is used",
    required: false
  })
  profileId?: string;
}

export class UpdatePlayerProfileInput {
  @ApiProperty({
    description: "Optional profileId to retrieve. If omitted, profile of current user is used",
    required: false
  })
  profileId?: string;

  @ApiProperty({
    description: "First name of player",
  })
  firstName?: string;

  @ApiProperty({
    description: "Last name of player",
  })
  lastName?: string;

  @ApiProperty({
    description: "Optional player nickname (searchable)",
    required: false
  })
  nickName?: string;

  @ApiProperty({
    description: "Optional url to uploaded profile image",
    required: false
  })
  imageUrl?: string;
}

export class ClaimTeamPlayerParams {
  @ApiProperty({
    description: "Team-Player uuid of annotated player to claim",
  })
  teamPlayerId?: string;
}

export class FollowPlayerParams {
  @ApiProperty({
    description: "Profile uuid to follow",
  })
  profileId?: string;
}

export class UnfollowPlayerParams {
  @ApiProperty({
    description: "Follow assignment uuid to remove",
  })
  followId?: string;
}

export class SearchPlayerProfilesInput {
  @ApiProperty({
    description: "String to search. Matches player name / nickname, or linked team names",
  })
  search: string;
}

export class GetPlayerProfileStatSummaryInput {
  @ApiProperty({
    description: "Optional source of annotation data",
    default: "ai",
    required: false,
    enum: AnnotationSources
  })  
  source: AnnotationSources;

  @ApiProperty({
    description: "Optional uuid of scheduled game to limit results",
    required: false
  })
  scheduledGameId: string;

  @ApiProperty({
    description: "Optional season string value to limit results",
    required: false
  })
  season: string;

  @ApiProperty({
    description: "Optional uuid of league to limit results",
    required: false
  })
  leagueId: string;

  @ApiProperty({
    description: "Optional uuid of arena to limit results",
    required: false
  })
  arenaId: string;

  @ApiProperty({
    description: "Optional uuid of team to limit results against",
    required: false
  })
  teamId: string;

  @ApiProperty({
    description: "Optional uuid of player profile to limit results against",
    required: false
  })
  profileId: string;
}