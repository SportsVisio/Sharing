import { closeOpenHandles } from './../../test/testbed';
import { SharedModule } from './../shared/shared.module';
import { HighlightsService } from '../highlights/highlights.service';
import { VideoService } from './video.service';
import { Test, TestingModule } from '@nestjs/testing';
import { VideoController } from './video.controller';

describe('Videos Controller', () => {
  let controller: VideoController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [SharedModule],
      controllers: [VideoController],
      providers: [VideoService, HighlightsService]
    }).compile();

    controller = module.get<VideoController>(VideoController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  afterAll(closeOpenHandles);
});
