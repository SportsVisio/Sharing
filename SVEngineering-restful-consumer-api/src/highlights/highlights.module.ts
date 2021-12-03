import { HighlightsService } from './highlights.service';
import { Module } from '@nestjs/common';
import { SharedModule } from "../shared/shared.module";

@Module({
  imports: [SharedModule],
  providers: [HighlightsService],
  exports: [HighlightsService],
  controllers: []
})
export class HighlightsModule {}
