import { SharedModule } from './../shared/shared.module';
import { closeOpenHandles } from './../../test/testbed';
import { Test, TestingModule } from '@nestjs/testing';
import { HighlightsService } from './highlights.service';

describe('HighlightsService', () => {
  let service: HighlightsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [SharedModule],
      providers: [HighlightsService],
    }).compile();

    service = module.get<HighlightsService>(HighlightsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should return Highlight(s) from valid Highlights key / annotation', async () => {
    const data = await service.get("vmx-7000", "shot1");
    expect(Array.isArray(data)).toBeTruthy();
  });

  afterAll(closeOpenHandles);
});
