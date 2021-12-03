import { ApiProperty } from "@nestjs/swagger";
import { AnnotationAction } from './annotation-action.entity';

export class PlayerStatRollup {
  @ApiProperty()
  made: number;
  
  @ApiProperty()
  attempts: number;
}

export class PlayerStatSummary {
  @ApiProperty()
  fieldGoals: PlayerStatRollup;
  
  @ApiProperty()
  threePoints: PlayerStatRollup;
  
  @ApiProperty()
  twoPoints: PlayerStatRollup;
  
  @ApiProperty()
  freeThrows: PlayerStatRollup;

  @ApiProperty()
  totalPoints: number;
  
  @ApiProperty()
  offensiveRebounds: number;
  
  @ApiProperty()
  defensiveRebounds: number;

  @ApiProperty()
  totalRebounds: number;

  @ApiProperty()
  assists: number;
}

export class PlayerStats {
  @ApiProperty({
    type: () => AnnotationAction,
    description: "Collection of player actions",
    isArray: true
  })
  actions: AnnotationAction[];

  @ApiProperty({
    type: () => PlayerStatSummary,
    description: "Summary rollup object for collection of actions"
  })
  summary: PlayerStatSummary;
}