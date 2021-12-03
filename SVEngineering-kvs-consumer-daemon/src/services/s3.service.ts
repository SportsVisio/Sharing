import { logger } from './../logger';
import { S3 } from "aws-sdk";
import { ListObjectsV2Output, GetObjectRequest, ListObjectsV2Request } from "aws-sdk/clients/s3";
import { IParsedFragment } from "./ebml.service";

const s3Bucket = `${process.env.FRAGMENT_S3_BUCKET || "kvs-video-fragments"}`;

export class S3Service {
  public client: S3;
  public get streamBucket(): string {
    return `${s3Bucket}/${this.stream}`;
  }

  constructor(
    private stream: string
  ) {
    this.client = new S3({
      // s3ForcePathStyle: true,
      useAccelerateEndpoint: true
    });
  }

  public writeFragment({ fragmentNumber, payload }: IParsedFragment, folder: string): Promise<boolean> {
    const filename = `fragment_${fragmentNumber}.mp4`;
    logger.info(`Writing ${filename} ...`);

    return this.client.putObject({
      Bucket: this.streamBucket,
      Key: `${folder}/${filename}`,
      Body: Buffer.from(payload),
    }).promise().then(() => {
      logger.info(`Done.`);
      return true;
    }).catch(err => {
      logger.error("Error writing fragment");
      logger.error(err);
      return false;
    });
  }

  public getObjects(params: ListObjectsV2Request): Promise<ListObjectsV2Output> {
    return this.client.listObjectsV2(params).promise();
  }

  public deleteObjects(objects: any[]): Promise<boolean> {
    if (!objects.length) return Promise.resolve(true);

    const params = {
      Bucket: this.streamBucket,
      Delete: {
        Objects: objects.map(o => ({ Key: o.Key })),
        Quiet: true
      }
    };

    return this.client.deleteObjects(params).promise().then(() => true).catch(err => {
      logger.error(err);
      return false;
    });
  }

  public getObject<T>(key: string): Promise<T> {
    const params: GetObjectRequest = {
      Bucket: this.streamBucket,
      Key: key
    };

    return this.client.getObject(params).promise().then(({ Body }) => Body as T);
  }
}