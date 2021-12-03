import { DataloopService } from './dataloop.service';
import { closeOpenHandles } from './../../test/testbed';
import { Test, TestingModule } from '@nestjs/testing';
import { DataloopController } from './dataloop.controller';

describe('DataloopController', () => {
  let controller: DataloopController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [],
      controllers: [DataloopController],
      providers: [DataloopService]
    }).compile();

    controller = module.get<DataloopController>(DataloopController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  afterAll(closeOpenHandles);
});
