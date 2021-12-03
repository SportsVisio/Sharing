/* eslint camelcase: "off" */

export interface IKinesysCheckpoint {
  kv_stream: string;
  timestamp: string;
  fragment_number: string;
}

export interface IKinesisParsedPayload {
  fragment: Blob;
  fragmentNumber: string;
  continuationToken: string;
  producerTimestamp: Date;
}