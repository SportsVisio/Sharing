import { S3 } from "aws-sdk";
import { ListObjectsV2Output, GetObjectRequest, ListObjectsV2Request, PutObjectOutput } from "aws-sdk/clients/s3";
import { Injectable, InternalServerErrorException } from "@nestjs/common";
import { logger } from "../common/logger";

@Injectable()
export class S3Service {
  public client: S3;

  constructor() {
    this.client = new S3({
      // s3ForcePathStyle: true,
      // useAccelerateEndpoint: true
    });
  }


  public getObjects(params: ListObjectsV2Request): Promise<ListObjectsV2Output> {
    return this.client.listObjectsV2(params).promise();
  }

  public getContents<T>(bucket: string, key: string): Promise<T> {
    const params: GetObjectRequest = {
      Bucket: bucket,
      Key: key
    };

    return this.client.getObject(params).promise().then(({ Body }) => Body as T);
  }

  public writeObject(bucket: string, filename: string, folder: string, payload: any): Promise<PutObjectOutput> {
    const key = `${folder}/${filename}`;
    logger.info(`Writing ${key} ...`);

    return this.client.putObject({
      Bucket: bucket,
      Key: key,
      Body: Buffer.from(payload),
    }).promise().then(output => {
      logger.info(`Done.`);
      return output;
    }).catch(err => {
      logger.error("Error writing object");
      logger.error(err);
      
      throw new InternalServerErrorException(err);
    });
  }
}