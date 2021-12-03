import { closeOpenHandles } from './../../test/testbed';
import { Test, TestingModule } from '@nestjs/testing';
import { VideoService } from './video.service';

describe('VideoService', () => {
  let service: VideoService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [VideoService],
    }).compile();

    service = module.get<VideoService>(VideoService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should return full video url from valid key', () => {
    expect(
      service.getPresignedFullVideoUrl("vmx-7000")
    ).resolves.toBeDefined();
  });

  // Only works when there is data in the stream ...
  it.skip('should return HLS video url from Stream Name', () => {
    expect(
      service.getHlsUrl("sportsVisio")
    ).resolves.toBeDefined();
  });

  afterAll(closeOpenHandles);
});
