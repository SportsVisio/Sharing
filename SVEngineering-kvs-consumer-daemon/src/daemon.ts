import { IKinesysCheckpoint } from './interfaces/checkpoints.interfaces';
import { logger } from './logger';
import { CheckpointTable, DynamoService } from './services/dynamo.service';
import { config } from "aws-sdk";
import { KinesisService } from "./services/kinesis.service";
import { config as dotenv } from "dotenv";
import { filter, map, switchMap, tap } from "rxjs/operators";
import { S3Service } from "./services/s3.service";
import { from, Observable } from "rxjs";
dotenv();

config.update({
  region: process.env.AWS_REGION || "us-east-1"
});

/* eslint camelcase: "off" */

export const processMedia = (streamName: string, gameId: string, videoId: string): Observable<string> => {
  logger.info(`[${streamName}] - Stream parser starting ...`);

  const svc = new KinesisService(streamName);

  return svc.getParsedStream().pipe(
    tap(({ fragmentNumber }) => {
      // bail out of the stream if no fragments are found
      if (!fragmentNumber) throw new Error("Empty Stream");
    }),
    filter(({ fragmentNumber }) => !!fragmentNumber),
    switchMap((parsed) => from(new S3Service(`${gameId}/${videoId}`).writeFragment(parsed, videoId)).pipe(
      map(() => parsed)      
    )),
    switchMap(({ fragmentNumber, continuationToken }) => from(new DynamoService().addRecord<IKinesysCheckpoint>(CheckpointTable, {
      kv_stream: streamName,
      timestamp: new Date().toUTCString(),
      fragment_number: fragmentNumber
    })).pipe(map(() => continuationToken))
    )
  );
};