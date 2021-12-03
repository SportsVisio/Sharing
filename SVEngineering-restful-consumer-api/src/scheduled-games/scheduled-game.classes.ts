import { ApiProperty } from '@nestjs/swagger';

export class GetScheduledGamesParams {
  @ApiProperty({
    description: "Optional account uuid to fetch all leagues. If not provided, current authenticated user account is used",
    required: false
  })
  accountId: string;
}

export class GetScheduledGameParams {
  @ApiProperty({
    description: "Scheduled Game uuid to fetch"
  })
  scheduledGameId: string;
}

export class ScheduledGameBase {
  @ApiProperty({
    description: "Optional description to display as the name of this game",
    required: false
  })
  description?: string;

  @ApiProperty({
    description: "LeagueId associated with this game"
  })
  leagueId?: string;

  @ApiProperty({
    description: "CourtId associated with this game"
  })
  courtId?: string;

  @ApiProperty({
    description: "Unix timestamp representing start of video capture timeframe"
  })
  startTime: number;

  @ApiProperty({
    description: "Unix timestamp representing the end of video capture timeframe"
  })
  endTime: number;

  @ApiProperty({
    description: "Game season",
    example: "Fall 2022"
  })
  season: string;
}
export class ScheduledGameTeamAssn {
  @ApiProperty({
    description: "Uuid of team to register",
  })
  teamId: string;

  @ApiProperty({
    description: "Team designation",
    example: "Home / Away, TeamA / TeamB"
  })
  designation: string;

  @ApiProperty({
    description: "Primary base color designation for team",
    example: "red"
  })
  color: string;
}
export class ScheduleGamePayloadBase extends ScheduledGameBase {
  @ApiProperty({
    description: "Teams to register. `Designation` should be something like TeamA/TeamB or Home/Away, etc.",
    isArray: true,
    type: () => ScheduledGameTeamAssn
  })
  teams: ScheduledGameTeamAssn[];
}

export class ScheduleGamePayload extends ScheduleGamePayloadBase {
  @ApiProperty({
    description: "Account uuid to schedule with. If omitted currently authenticated user account is used",
    required: false
  })
  accountId?: string;
}

export class UpdateScheduledGameParams {
  @ApiProperty({
    description: "Scheduled Game uuid to update"
  })
  scheduledGameId: string;
}

export class UpdateScheduledGamePayload extends ScheduledGameBase {
}