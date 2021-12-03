import { ApiProperty } from "@nestjs/swagger";

export class GetLeagueParams {
  @ApiProperty({
    description: "League uuid to fetch"
  })
  leagueId: string;
}

export class CreateLeaguePayload {
  @ApiProperty({
    description: "Name of league, publicly visible"
  })
  name: string; 
}

export class UpdateLeagueParams {
  @ApiProperty({
    description: "Uuid of League to update"
  })
  leagueId: string;
}

export class UpdateLeaguePayload {
  @ApiProperty({
    description: "Name of league, publicly visible"
  })
  name: string; 
}
