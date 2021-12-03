import { KinesisService } from './../shared/kinesis.service';
import { DeviceScheduledGameAssn } from './device-game-assn.entity';
import { ScheduledGame } from '../scheduled-games/scheduled-game.entity';
import { DeviceStream } from './device-stream.entity';
import { Lambda } from 'aws-sdk';
import { Device } from './device.entity';
import { Account } from '../account/account.entity';
import { logger } from './../common/logger';
import { Injectable, BadRequestException, InternalServerErrorException } from '@nestjs/common';
import { FindManyOptions, Repository } from 'typeorm';
import { InjectRepository } from "@nestjs/typeorm";
import { AttachDeviceScheduledGamePayload } from "./device.classes";
import { catchError, from, lastValueFrom, map, switchMap } from "rxjs";
import { PromisedNotFoundException } from "../common/constants";

const PROCESSING_LAMBDA_FUNCTION = process.env.PROCESSING_LAMBDA_FUNCTION || "kvs-consumer-daemon-dev-main";

@Injectable()
export class DevicesService {
  constructor(
    private kinesis: KinesisService,
    @InjectRepository(Device)
    public devices: Repository<Device>,
    @InjectRepository(DeviceStream)
    public deviceStreams: Repository<DeviceStream>,
    @InjectRepository(ScheduledGame)
    public games: Repository<ScheduledGame>,
    @InjectRepository(DeviceScheduledGameAssn)
    public deviceGameAssignments: Repository<DeviceScheduledGameAssn>,
    @InjectRepository(Account)
    public accounts: Repository<Account>
  ) { }

  public async list(accountId: string): Promise<Device[]> {
    return this.devices.find({
      where: {
        account: {
          id: accountId
        }
      }
    });
  }

  public get(deviceId: string, options?: Partial<FindManyOptions<Device>>): Promise<Device> {
    return this.devices.findOneOrFail(deviceId, options).catch(PromisedNotFoundException);
  }

  public create(deviceId: string, name: string, accountId: string): Promise<Device> {
    return lastValueFrom(
      from(this.accounts.findOneOrFail(accountId).catch(PromisedNotFoundException)).pipe(
        switchMap(async account => {
          const [device] = await this.devices.find({
            where: {
              deviceId
            },
            relations: ["stream"],
            withDeleted: true
          });
          if (device && !device.deletedAt) throw new BadRequestException(`Device id ${deviceId} has already been registered`);

          return device?.deletedAt ? device.recover({ stream: { id: device.stream.id, deletedAt: null }}) : this.devices.create({
            account,
            name,
            deviceId
          }).save();
        }),
        switchMap(async (device) => {          
          try {
            await this.registerStream(device);
          }
          catch (exc) {
            // if the stream fails to register, delete the device
            await device.softRemove();
            throw exc;
          }

          return device.toJSON() as Device;
        }),
        catchError(exc => {
          logger.error("Error registering device");
          logger.error(exc);

          throw exc;
        })
      )
    );
  }

  public delete(id: string): Promise<boolean> {
    return this.devices.softDelete({ id }).then(async () => {
      await this.kinesis.unregister(id);
      // soft delete this since the streamName will always be the same
      await this.deviceStreams.softDelete({ device: { id } });

      return true;
    });
  }

  public async attachScheduledGame({ deviceId, videoId, startTime, endTime, gameId }: AttachDeviceScheduledGamePayload): Promise<boolean> {
    if (!videoId) throw new BadRequestException("Must specify a videoId (some-file.mp4)");
    if (!startTime) throw new BadRequestException("No start time specified");
    if (!endTime) throw new BadRequestException("No end time specified");

    const device = await this.devices.findOneOrFail(deviceId, {
      relations: ["gameAssn"]
    }).catch(PromisedNotFoundException);
    const game = await this.games.findOneOrFail(gameId).catch(PromisedNotFoundException);

    const [result] = await this.deviceGameAssignments.find({
      where: {
        device: {
          id: device.id
        },
        game: {
          id: game.id
        }
      },
      withDeleted: true
    });

    // make sure we don't double-attach
    if (result?.deletedAt) result.deletedAt = null;
    else if (result) throw new BadRequestException("That device is already attached to this game; nothing to do");

    return (result ? result.save() : this.deviceGameAssignments.create({
      game,
      device,
      videoId,
      startTime,
      endTime,
      isActive: false
    }).save()).then(() => true);
  }

  public unattachScheduledGame(deviceAssnId: string): Promise<boolean> {
    return this.deviceGameAssignments.delete({
      id: deviceAssnId
    }).then(() => true);
  }

  public updateGameAttachment(deviceAssnId: string, values: Partial<DeviceScheduledGameAssn>): Promise<boolean> {
    return this.deviceGameAssignments.update({
      id: deviceAssnId
    }, values).then(() => true);
  }

  public async getDeviceGameAssignment(assnId: string, throwError = true): Promise<DeviceScheduledGameAssn> {
    const record = await this.deviceGameAssignments.findOne(assnId);
    if (!record && throwError) throw new BadRequestException("Stream not found");

    return record;
  }

  public async startStream(deviceAssnId: string): Promise<boolean> {
    const {
      device: {
        id: deviceId,
        stream: {
          streamName
        }
      },
      isActive
    } = await this.getDeviceGameAssignment(deviceAssnId);
    if (isActive) throw new BadRequestException("Stream processing has already been started.");

    logger.info(`Starting streaming services for Device: ${deviceId} - ${streamName}`);

    return this.updateGameAttachment(deviceAssnId, { isActive: true }).then(result => new Lambda().invoke({
      FunctionName: PROCESSING_LAMBDA_FUNCTION,
      InvocationType: 'Event',
      LogType: 'Tail',
      Payload: JSON.stringify({ deviceAssnId })
    }).promise().then(() => result));
  }

  public async stopStream(deviceAssnId: string): Promise<boolean> {
    const {
      device: {
        id: deviceId,
        stream: {
          streamName
        }
      }
    } = await this.getDeviceGameAssignment(deviceAssnId);

    logger.info(`Stopping streaming services for Device: ${deviceId} - ${streamName}`);

    return this.updateGameAttachment(deviceAssnId, { isActive: false });
  }

  private async registerStream(device: Device): Promise<string> {
    const streamName = await this.kinesis.register(device.id);

    const [stream] = await this.deviceStreams.find({
      where: {
        device
      },
      withDeleted: true
    });

    if (stream) {
      await stream.recover();
      return streamName;
    }

    await this.deviceStreams.create({
      device,
      streamName,
    }).save();
    
    logger.info(`Stream registered for Device: ${device.id} - ${streamName}`);

    return streamName;
  }
}
