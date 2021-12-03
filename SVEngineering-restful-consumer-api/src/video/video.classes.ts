import { ApiProperty } from '@nestjs/swagger';

export class GetFullVideoParams {
  @ApiProperty({
    description: "String id of requested video"
  })
  id: string;
}

export class GetHlsVideoParams {
  @ApiProperty({
    description: "String name of requested video stream"
  })
  stream: string;
}

export class GetPlaybackVideoParams {
  @ApiProperty({
    description: "String name of requested video stream"
  })
  stream: string;

  @ApiProperty({
    description: "Unix timestamp of starting position for playback stream"
  })
  timestamp: number;
}

export class GetHighlightsParams {
  @ApiProperty({
    description: "String id of requested video"
  })
  id: string;

  @ApiProperty({
    description: "Annotation to filter highlights"
  })
  annotation: string;
}

export class SliceVideoMarker {
  @ApiProperty({
    description: "Time marker to start slice at",
    example: "00:00:05"
  })
  start: string;

  @ApiProperty({
    description: "Time marker in seconds to stop slice at",
    example: "15"
  })
  duration: string;
}

export class SliceVideoInputParams {
  @ApiProperty({
    description: "String id of requested video"
  })
  videoId: string;
}

export class SliceVideoInputPayload {
  @ApiProperty({
    description: "Time markers to slice",
    isArray: true,
    type: () => [SliceVideoMarker]
  })
  markers: SliceVideoMarker[];
  
  @ApiProperty({
    description: "Optional source S3 Bucket to find videoId",
    default: "sportsvisio-transcoded-videos",
    required: false
  })
  sourceBucket?: string;
  
  @ApiProperty({
    description: "Optional destination S3 bucket to store clipped videos",
    default: "sliced-video-clips",
    required: false
  })
  destinationBucket?: string;
}