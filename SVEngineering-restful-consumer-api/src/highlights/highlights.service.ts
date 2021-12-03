import { IDynamoVideoHighlight, IVideoHighlight } from './highlights.classes';
import { logger } from './../common/logger';
import { Injectable } from '@nestjs/common';
import { DynamoService } from "../shared/dynamo.service";
import { S3 } from "aws-sdk";

const DYNAMO_TABLE = process.env.HIGHLIGHTS_DYNAMO_TABLE || "HighlightsData";

@Injectable()
export class HighlightsService {
  public s3 = new S3();
  constructor(
    public dynamo: DynamoService
  ) {
  }

  public async get(videoId: string, annotation: string): Promise<IVideoHighlight[]> {
    try {
      const records = await this.dynamo.query<IDynamoVideoHighlight>(DYNAMO_TABLE, {
        ExpressionAttributeValues: {
          ":videoId": videoId,
          ":annotation": annotation
        } as any,
        KeyConditionExpression: `VideoID = :videoId`,
        FilterExpression: `contains (Annotation, :annotation)`
      });

      return Promise.all(
        records.filter(({ S3Link }) => !!S3Link).map(async ({
          S3Link,
          VideoID,
          ProducerTimestamp,
          ClipStartTime,
          ClipEndTime,
          Annotation
        }) => {
          const [bucket, ...key] = S3Link.substr(5).split("/");
          return {
            videoId: VideoID,
            producerTimestamp: new Date(ProducerTimestamp),
            clipStartTime: new Date(ClipStartTime),
            clipEndTime: new Date(ClipEndTime),
            annotation: Annotation,
            signedUrl: await this.s3.getSignedUrl("getObject", {
              Bucket: bucket,
              Key: key.join("/")
            })
          };
        })
      );
    }
    catch (exc) {
      logger.error(exc);
      throw exc;
    }
  }
}
