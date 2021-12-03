import { ApiProperty } from "@nestjs/swagger";

export class SearchTeamsInput {
  @ApiProperty({
    description: "String to search. Matches team names.",
  })
  search: string;
}

export class GetTeamsParams {
  @ApiProperty({
    description: "Optional account uuid to fetch all teams. If not provided, current authenticated user account is used",
    required: false
  })
  accountId: string;
}

export class GetTeamParams {
  @ApiProperty({
    description: "Team uuid to fetch"
  })
  teamId: string;
}

export class CreateTeamPayload {
  @ApiProperty({
    description: "Name of team, publicly visible"
  })
  name: string;

  @ApiProperty({
    description: "Optional url to uploaded profile image",
    required: false
  })
  imageUrl?: string;
}

export class CreateTeamPlayerParams {
  @ApiProperty({
    description: "Uuid of team to add player"
  })
  teamId?: string;
}

export class CreateTeamPlayerPayload {
  @ApiProperty({
    description: "Jersey number of player"
  })
  number: string;

  @ApiProperty({
    description: "Full searchable name of player"
  })
  name: string;
}

export class UpdateTeamPlayerParams {
  @ApiProperty({
    description: "Team Player uuid to update"
  })
  teamPlayerId: string;
}

export class UpdateTeamPlayerPayload {
  @ApiProperty({
    description: "Jersey number of player"
  })
  number: string;

  @ApiProperty({
    description: "Full searchable name of player"
  })
  name: string;
}

export class UpdateTeamParams {
  @ApiProperty({
    description: "Uuid of team to update"
  })
  teamId?: string;
}

export class UpdateTeamPayload {
  @ApiProperty({
    description: "Name of team, publicly visible"
  })
  name: string;

  @ApiProperty({
    description: "Optional url to uploaded profile image",
    required: false
  })
  imageUrl?: string;
}