import { HighlightsService } from './../highlights/highlights.service';
import { Module } from '@nestjs/common';
import { VideoService } from './video.service';
import { VideoController } from './video.controller';
import { HighlightsModule } from "../highlights/highlights.module";
import { SharedModule } from "../shared/shared.module";

@Module({
  imports: [SharedModule, HighlightsModule],
  providers: [VideoService, HighlightsService],
  exports: [VideoService],
  controllers: [VideoController]
})
export class VideoModule {}
