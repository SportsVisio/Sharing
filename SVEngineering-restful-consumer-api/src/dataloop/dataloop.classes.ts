import { SliceVideoInputParams } from './../video/video.classes';
import { ApiProperty } from '@nestjs/swagger';

export const DATALOOP_ENDPOINT = process.env.DATALOOP_ENDPOINT || "https://gate.dataloop.ai/api/v1";
export const DATALOOP_AUTH_ENDPOINT = process.env.DATALOOP_AUTH_ENDPOINT || "https://dataloop-production.auth0.com";

export class DownloadAnnotationsParams {
  @ApiProperty({
    description: "Dataloop Dataset Id"
  })
  datasetId: string;
}

export class SliceAndSyncInputParams extends SliceVideoInputParams {
  @ApiProperty({
    description: "String id of the Dataloop Dataset"
  })
  datasetId: string;
}

/* eslint camelcase: off */
export interface IDataloopOAuthInput {
  client_id: string;
  client_secret: string;
  audience: string;
  grant_type: string;
  username: string;
  password: string;
  scope: string;
}

export const DataLoopConfigFactory = (): IDataloopOAuthInput => ({
  client_id: process.env.DATALOOP_CLIENT_ID || "",
  client_secret: process.env.DATALOOP_SECRET || "",
  audience: `${DATALOOP_ENDPOINT}/api/v2`,
  grant_type: "password",
  username: process.env.DATALOOP_USER_EMAIL || "",
  password: process.env.DATALOOP_USER_PASS || "",
  scope: "openid email"
});
