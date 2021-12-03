import { ApiProperty } from "@nestjs/swagger";

export class GetArenaParams {
  @ApiProperty({
    description: "Arena uuid to fetch"
  })
  arenaId: string;
}

export class CreateArenaPayload {
  @ApiProperty({
    description: "Name of arena, publicly visible"
  })
  name: string;
}

export class CreateArenaCourtParams {
  @ApiProperty({
    description: "Uuid of arena to add court"
  })
  arenaId?: string;
}

export class CreateArenaCourtPayload {
  @ApiProperty({
    description: "Full searchable name of court"
  })
  name: string;
}

export class UpdateArenaCourtParams {
  @ApiProperty({
    description: "Arena court uuid to update"
  })
  courtId: string;
}

export class UpdateArenaCourtPayload {
  @ApiProperty({
    description: "Full searchable name of court"
  })
  name: string;
}

export class UpdateArenaParams {
  @ApiProperty({
    description: "Uuid of arena to update"
  })
  arenaId?: string;
}

export class UpdateArenaPayload {
  @ApiProperty({
    description: "Name of arena, publicly visible"
  })
  name: string;
}