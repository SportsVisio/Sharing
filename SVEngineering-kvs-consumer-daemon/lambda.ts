import { SportsVisioService } from './src/services/sportsvisio.service';
import { logger } from './src/logger';
import { processMedia } from './src/daemon';
import { IDeviceStreamData } from './src/interfaces/streams.interfaces';
import { Handler, Context } from 'aws-lambda';
import { catchError, switchMap, tap } from "rxjs/operators";
import { Lambda } from "aws-sdk";
import { timer } from "rxjs";

export const handler: Handler = async ({ body: Payload }: any, { functionName, invokedFunctionArn }: Context) => {
  const { deviceAssnId } = typeof Payload === "string" ? JSON.parse(Payload) : Payload;
  
  const mysql = new SportsVisioService();
  const operation = `SELECT isActive, startTime, endTime, videoId, streamName, device.deviceId, gameId 
  FROM device_scheduled_game_assn a inner join device on device.id = a.deviceId inner join device_stream b on b.deviceId = device.id  
  WHERE a.id = ?`;

  const [record] = await mysql.query<IDeviceStreamData[]>(operation, [deviceAssnId]);
  if (!record) throw new Error("Stream data not found");

  // TODO - logic for startTime, right now just keep checking until end time lapses
  const { isActive, streamName, startTime, endTime, deviceId, videoId, gameId } = record;
  if (!isActive) {
    logger.error(`Stream is not active... bailing out!`);
    return Promise.resolve(void 0);
  }

  logger.info(`Starting Lambda Stream Processing for Device: ${deviceId} - ${streamName}`)

  await processMedia(streamName, gameId, videoId).pipe(
    // if the stream threw an error, wait 1s before retying (no fragment data)
    catchError((err) => timer(1000)),
    tap(() => console.log("Calling recursively ...")),
    tap(() => {
      // if we've lapsed our end time, bail out
      if (endTime < Date.now()) throw new Error("");
    }),
    // trigger self recursively until tap above throws an error
    switchMap(() => new Lambda({
      endpoint: invokedFunctionArn.includes("offline") ? "http://0.0.0.0:3001" : "https://lambda.us-east-1.amazonaws.com"
    }).invoke({
      FunctionName: functionName,
      InvocationType: 'Event',
      LogType: 'Tail',
      Payload
    }).promise().catch(err => console.log(err)))
  ).toPromise();
};