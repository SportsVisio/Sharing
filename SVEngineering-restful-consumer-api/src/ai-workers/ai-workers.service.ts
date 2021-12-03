import { NotFoundException, BadRequestException, Injectable } from '@nestjs/common';
import { ScheduledGameService } from './../scheduled-games/scheduled-game.service';
import { logger } from './../common/logger';
import { IAiWorkerInstanceData } from "./ai-workers.interfaces";
import { createPool, Pool } from "mysql2";
import { promisify } from "util";
import { EC2 } from "aws-sdk";
import { PromisedBadRequestException, UnixTimestamp } from "../common/utilities";
import { S3Service } from "../shared/s3.service";
import { DeviceFragmentDetail } from "./ai-workers.classes";

const FRAGMENT_S3_BUCKETBASE = `${process.env.FRAGMENT_S3_BUCKET || "kvs-video-fragments"}`;

@Injectable()
export class AiWorkerService {
  private connection: Pool;
  private ec2Client: EC2 = null;

  public get amiId(): string {
    return process.env.AI_WORKER_AMI || "ami-087c17d1fe0178315";
  }

  public get query(): any {
    return promisify(this.connection.query).bind(this.connection);
  }

  constructor(
    private games: ScheduledGameService,
    private s3: S3Service
  ) {
    this.connection = createPool({
      connectionLimit: 10,
      host: process.env.GLOBAL_DB_ENDPOINT || "0.0.0.0",
      user: process.env.GLOBAL_DB_USER || "admin",
      password: process.env.GLOBAL_DB_PASS || "root12345",
      database: "global_ai_workers"
    });

    this.ec2Client = new EC2({ apiVersion: '2016-11-15' });
  }

  public list(): Promise<IAiWorkerInstanceData[]> {
    return this.query("SELECT * FROM ec2_workers", null).catch(PromisedBadRequestException);
  }

  public async get(instanceId: string): Promise<IAiWorkerInstanceData> {
    const result = await this.query("SELECT * FROM ec2_workers where instanceId = ?", [instanceId]).catch(PromisedBadRequestException);
    if (!result.length) throw new NotFoundException("No worker data found matching instanceId");

    const data = result[0];

    data.s3VideoFolders = await this.getFragmentFolderUrls(data.scheduledGameId);

    return data;
  }

  public async start(gameId: string): Promise<IAiWorkerInstanceData> {
    // make sure this game exists
    await this.games.get(gameId);

    let instanceId;
    const [instanceData] = (await this.list()).filter(({ terminating, idle }) => !terminating && idle).sort((a, b) => a.lastAction - b.lastAction);

    if (!instanceData) {
      const { Instances: [instance] } = await this.ec2Client.runInstances({
        ImageId: this.amiId,
        InstanceType: 't2.nano',
        KeyName: 'higherhrnet-instance',
        MinCount: 1,
        MaxCount: 1,
        UserData: Buffer.from(`#!/bin/bash
        export NODE_ENV=${process.env.NODE_ENV || 'dev'}
        `).toString("base64")
      }).promise();
      const { InstanceId: _id } = instance;

      instanceId = _id;

      logger.info(`Instance created: ${instanceId}`);

      await this.query("INSERT into ec2_workers (instanceId, lastAction, idle, terminating, scheduledGameId) VALUES (?, ?, ?, ?, ?)", [
        instanceId, UnixTimestamp(), false, false, gameId
      ]).catch(PromisedBadRequestException);
    }
    else {
      instanceId = instanceData.instanceId;

      await this.ec2Client.startInstances({
        InstanceIds: [instanceId]
      }).promise();

      await this.query("UPDATE ec2_workers set lastAction = ?, idle = 0, scheduledGameId = ? where instanceId = ?", [UnixTimestamp(), gameId, instanceId]).catch(PromisedBadRequestException);
    }

    return this.get(instanceId);
  }

  public async stop(instanceId: string): Promise<boolean> {
    const { idle, terminating } = await this.get(instanceId);
    if (idle || terminating) throw new BadRequestException("Invalid instance state for requested action; bailing out.");

    await this.ec2Client.stopInstances({
      InstanceIds: [instanceId]
    }).promise();

    await this.query("UPDATE ec2_workers set idle = 1, lastAction = ? where instanceId = ?", [UnixTimestamp(), instanceId]).catch(PromisedBadRequestException);
    return Promise.resolve(true);
  }

  public async getFragmentFolderUrls(gameId: string): Promise<DeviceFragmentDetail[]> {
    try {
      const game = await this.games.get(gameId, {
        relations: ["deviceGameAssn", "deviceGameAssn.device"]
      });
      const { CommonPrefixes } = await this.s3.getObjects({
        Bucket: FRAGMENT_S3_BUCKETBASE,
        Delimiter: "/",
        Prefix: `${gameId}/`
      });

      if (!CommonPrefixes?.length) {
        logger.info(`No output data found at ${FRAGMENT_S3_BUCKETBASE}/${gameId}`);
      }

      return CommonPrefixes.map(({ Prefix: p }) => p.split("/")[1]).map(s => ({
        s3Location: `${FRAGMENT_S3_BUCKETBASE}/${gameId}/${s}`,
        deviceGameAssnId: s,
        device: game.deviceGameAssn.find(({ id }) => id === s)?.device
      }));
    }
    catch (exc) {
      logger.error(exc);
      return [];
    }
  }

}
