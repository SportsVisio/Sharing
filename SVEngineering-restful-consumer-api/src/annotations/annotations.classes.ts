import { AnnotationActionQualifiers } from './annotation-action-qualifier.entity';
import { AnnotationAction, AnnotationActions } from './annotation-action.entity';
import { AnnotationActorTypes } from './annotation-actor.entity';
import { ApiProperty } from "@nestjs/swagger";
import { Annotation, AnnotationSources } from "./annotation.entity";

export class GetAnnotationsParams {
  @ApiProperty({
    description: "Optional player profile uuid. If not provided, profile of currently authenticated user is used",
    required: false
  })
  profileId: string;  
}

export interface IAnnotationImport {
  "data-id": string;
  "video-name": "somefile.mp4";
  "input-type": "AR";
  "frame-resolution": "2048, 1152";
  "frame-rate": 29.97;
  "frame-skip": 5;
  "processing-window-size": 100;
  "processing-window-overlap": 50;
  ids: {
    [identifier: string]: {
      type: AnnotationActorTypes;
      designation?: "home team | away team | jaguars | smallville high";
      attributes: string[];
    };
  };
  actions: {
    "start-time": "00:02:34:123";
    "start-frame": 5000;
    action: AnnotationActions;
    "action-qualifier": AnnotationActionQualifiers[];
    "action-confidence": 0.75;
    "player-id": string;
    "player-location": string;
  }[];
}

export class ImportAnnotationParams {
  @ApiProperty({
    description: "Scheduled game uuid"
  })
  scheduledGameId: string;
}

export class ImportAnnotationPayload {
  @ApiProperty({
    description: "JSON output from AI processing"
  })
  payload: IAnnotationImport;

  @ApiProperty({
    description: "Source of annotation data"
  })
  source: AnnotationSources;
}

export class AnnotationActionOutput extends AnnotationAction {
  @ApiProperty({
    description: "Parent annotation record for this action",
    type: () => Annotation
  })
  annotation: Annotation;
}