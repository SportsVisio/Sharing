import { logger } from './../common/logger';
import { KinesisVideo } from 'aws-sdk';
import { Injectable } from '@nestjs/common';
import { CreateStreamInput } from "aws-sdk/clients/kinesis";

@Injectable()
export class KinesisService {
  constructor(
  ) { }

  public async register(deviceId: string, options: Partial<CreateStreamInput> = {}): Promise<string> {
    const kinesis = new KinesisVideo();
    const streamName = this.getStreamName(deviceId);
    
    try {
      await kinesis.createStream({
        ...options,
        StreamName: streamName,
        DataRetentionInHours: 24,
        DeviceName: deviceId,
      }).promise();
    }
    catch (exc) {
      logger.error("Error creating Kinesis stream");
      logger.error(exc);

      throw exc;
    }
    
    logger.info(`Stream registered: ${streamName}`);

    return streamName;
  }

  public async unregister(deviceId: string): Promise<boolean> {
    const kinesis = new KinesisVideo();
    const { StreamInfo: { StreamARN } } = await kinesis.describeStream({
      StreamName: this.getStreamName(deviceId),
    }).promise();

    logger.info(`Unregistering stream ${StreamARN} for Device: ${deviceId}`);

    return await kinesis.deleteStream({
      StreamARN
    }).promise().then(() => true);
  }

  private getStreamName(deviceId: string): string {
    return `dyn-${deviceId}`;
  }
}
