import { S3Service } from './s3.service';
import { KinesisService } from './kinesis.service';
import { DynamoService } from './dynamo.service';
import { Global, Module } from '@nestjs/common';
import { config } from "aws-sdk";

import { config as dotenv } from "dotenv";
dotenv();

config.update({
  region: process.env.AWS_REGION || "us-east-1"
});

@Global()
@Module({
  imports: [],
  providers: [
    KinesisService,
    DynamoService,
    S3Service
  ],
  exports: [
    KinesisService,
    DynamoService,
    S3Service
  ],
  controllers: []
})
export class SharedModule {
  constructor() {
  }
}
