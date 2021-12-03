import { DataloopService } from './dataloop.service';
import { closeOpenHandles } from './../../test/testbed';
import { Test, TestingModule } from '@nestjs/testing';

describe('DataloopService', () => {
  let service: DataloopService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [],
      providers: [DataloopService],
    }).compile();

    service = module.get<DataloopService>(DataloopService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  afterAll(closeOpenHandles);
});
