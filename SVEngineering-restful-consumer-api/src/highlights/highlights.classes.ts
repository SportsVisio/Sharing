import { ApiProperty } from '@nestjs/swagger';
export interface IDynamoVideoHighlight {
  VideoID: string;
  ProducerTimestamp: Date;
  ClipStartTime: Date;
  ClipEndTime: Date;
  Annotation: string;
  S3Link: string;
}

export interface IVideoHighlight {
  videoId: string;
  producerTimestamp: Date;
  clipStartTime: Date;
  clipEndTime: Date;
  annotation: string;
  signedUrl: string;
}

export class VideoHighlight implements IVideoHighlight {
  @ApiProperty({
    description: "Unique video identifier"
  })
  videoId: string;

  @ApiProperty()
  producerTimestamp: Date;

  @ApiProperty()
  clipStartTime: Date;
  
  @ApiProperty()
  clipEndTime: Date;

  @ApiProperty({
    description: "Annotation to filter"
  })
  annotation: string;

  @ApiProperty({
    description: "Signed S3 link to the video highlight"
  })
  signedUrl: string;
}