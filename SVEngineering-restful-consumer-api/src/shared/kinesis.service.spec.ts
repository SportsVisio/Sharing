import { SharedModule } from './shared.module';
import { closeOpenHandles } from './../../test/testbed';
import { Test, TestingModule } from '@nestjs/testing';
import { KinesisService } from './kinesis.service';

const DEVICE_ID = "jestTest12345";

describe('KinesisService', () => {
  let service: KinesisService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [
        SharedModule
      ],
      providers: [KinesisService],
    }).compile();

    service = module.get<KinesisService>(KinesisService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should register and create Kinesis stream from valid DeviceId', async () => {
    await expect(
      service.register(DEVICE_ID)
    ).resolves.toBeDefined();
  });

  it('should unregister and remove new stream from valid DeviceId', async () => {
    await expect(
      service.unregister(DEVICE_ID)
    ).resolves.toBeTruthy();
  });

  afterAll(closeOpenHandles);
});
