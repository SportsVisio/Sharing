import { logger } from './../logger';
import { IKinesysCheckpoint } from '../interfaces/checkpoints.interfaces';
import { CheckpointTable, DynamoService } from './dynamo.service';
import { from, Observable, ReplaySubject, Subject } from 'rxjs';
import { take, map, switchMap, tap, startWith, filter } from 'rxjs/operators';
import { KinesisVideo } from "aws-sdk";
import KinesisVideoMedia, { GetMediaInput, Payload } from "aws-sdk/clients/kinesisvideomedia";
import { decode, IParsedFragment } from "./ebml.service";

export class KinesisService {
  private k = new KinesisVideo();
  private mediaClient: KinesisVideoMedia;
  private dynamo = new DynamoService();

  private _mediaEndpoint$ = new ReplaySubject<string>(1);
  public get mediaEndpoint$(): Observable<string> {
    return this._mediaEndpoint$;
  }

  private _mediaStream$ = new Subject<any>();
  public get mediaStream$(): Subject<any> {
    return this._mediaStream$;
  }

  private continuationToken$ = new Subject<string>();
  public set continuationToken(value: string) {
    this.continuationToken$.next(value);
  }

  constructor(
    public streamName: string
  ) {
    logger.info("Fetching Kinesis Endpoint ...");
    from(
      this.k.getDataEndpoint({
        APIName: "GET_MEDIA",
        StreamName: streamName
      }).promise().catch(err => {
        logger.error(`Unable to retrieve stream data for ${streamName}: ${err.message}`);
        
        // need to emit a value so that the rest of the chain can deal with it being not found separately
        this._mediaEndpoint$.next(null);
        return null;
      })
    ).pipe(
      filter(endpoint => !!endpoint),
      map(({ DataEndpoint: endpoint }) => endpoint),
      tap(endpoint => logger.info(`HLS Endpoint: ${endpoint}`)),
      take(1),
      tap(endpoint => this.mediaClient = new KinesisVideoMedia({ endpoint }))
    ).subscribe(endpoint => this._mediaEndpoint$.next(endpoint));
  }

  public getRawStream(): Observable<Payload> {
    return this.continuationToken$.pipe(
      startWith(""),
      switchMap((token) => this.getMedia(token))
    );
  }

  public getParsedStream(): Observable<IParsedFragment> {
    return this.getRawStream().pipe(
      map((payload) => decode(payload as Uint8Array)),
    );
  }

  private getMedia(continuationToken: string): Observable<Payload> {
    // only query Dynamo if we don't have a continuation token (performance)
    return from(
      !continuationToken ? this.dynamo.query<IKinesysCheckpoint>(CheckpointTable, {
        ExpressionAttributeValues: {
          ":kv_stream": this.streamName
        } as any,
        KeyConditionExpression: `kv_stream = :kv_stream`,
        ScanIndexForward: false,
        Limit: 1,
        ConsistentRead: true
      }).then(([fragment]) => fragment) : Promise.resolve(null)
    ).pipe(
      // inner observable to be certain the endpoint has resolved
      switchMap(fragment => this.mediaEndpoint$.pipe(
        tap(endpoint => {
          if (!endpoint) throw new Error("Endpoint not found");
        }),        // map the fragment back into the stream
        map(() => {
          const params: GetMediaInput = {
            StreamName: this.streamName,
            StartSelector: {
              StartSelectorType: "EARLIEST",              
            }
          };

          // serial requests use the token (safest)
          if (continuationToken) {
            logger.info(`Starting with token: ${continuationToken}`);
            params.StartSelector = {
              StartSelectorType: "CONTINUATION_TOKEN",              
              ContinuationToken: continuationToken
            };
          }
          // if we have a fragment but no token we must be recovering from an error or just starting up
          else if (fragment) {
            logger.info(`Starting from fragment: ${fragment.fragment_number}`);
            params.StartSelector = {
              StartSelectorType: "FRAGMENT_NUMBER",
              AfterFragmentNumber: fragment.fragment_number
            };
          }
          else {
            logger.info("Returning earliest available ...");
          }

          return params;
        })
      )),
      switchMap((params) => this.mediaClient.getMedia(params).promise()),
      map(({ Payload: p }) => p),
    );
  }
}
