import { S3 } from 'aws-sdk';
import { JwtAuthGuard } from './../auth/passport/jwt.auth-guard';
import { IVideoHighlight, VideoHighlight } from './../highlights/highlights.classes';
import { VideoService } from './video.service';
import { GetFullVideoParams, GetHighlightsParams, GetHlsVideoParams, GetPlaybackVideoParams, SliceVideoInputParams, SliceVideoInputPayload } from "./video.classes";
import { Body, Controller, Get, Param, Post, UseGuards } from '@nestjs/common';
import { ApiResponse, ApiBearerAuth, ApiHeader, ApiTags, ApiConsumes, ApiBody } from '@nestjs/swagger';
import { SwaggerHeaderDefaults } from "../common/constants";
import { HighlightsService } from "../highlights/highlights.service";

@Controller('video')
@ApiTags("Video")
export class VideoController {
  constructor(
    public videoSvc: VideoService,
    public highlightsSvc: HighlightsService
  ) { }

  @UseGuards(JwtAuthGuard)
  @Get("full/:id")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Video found.', type: String })
  @ApiResponse({ status: 404, description: 'Video not found.' })
  public full(@Param() { id }: GetFullVideoParams): Promise<string> {
    return this.videoSvc.getPresignedFullVideoUrl(id);
  }

  @UseGuards(JwtAuthGuard)
  @Get("hls/:stream")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Stream found.', type: String })
  @ApiResponse({ status: 404, description: 'Stream not found, or contains no fragments.' })
  public hls(@Param() { stream }: GetHlsVideoParams): Promise<string> {
    return this.videoSvc.getHlsUrl(stream);
  }

  @UseGuards(JwtAuthGuard)
  @Get("playback/:stream/:timestamp")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiResponse({ status: 200, description: 'Stream found.', type: String })
  @ApiResponse({ status: 404, description: 'Stream not found, or contains no fragments.' })
  public playback(@Param() { stream, timestamp }: GetPlaybackVideoParams): Promise<string> {
    return this.videoSvc.getHlsUrl(stream, {
      PlaybackMode: "LIVE_REPLAY",
      HLSFragmentSelector: {
        FragmentSelectorType: "PRODUCER_TIMESTAMP",
        TimestampRange: {
          StartTimestamp: new Date(timestamp * 1000)
        }
      }
    });
  }

  // @UseGuards(JwtAuthGuard)
  // @Get("highlights/:id/:annotation")
  // @ApiBearerAuth()
  // @ApiHeader(SwaggerHeaderDefaults)
  // @ApiResponse({ status: 200, description: 'Highlight(s) found.', type: VideoHighlight, isArray: true })
  // @ApiResponse({ status: 404, description: 'Highlight(s) not found.' })
  // public highlights(@Param() { id, annotation }: GetHighlightsParams): Promise<IVideoHighlight[]> {
  //   return this.highlightsSvc.get(id, annotation);
  // }

  // @UseGuards(JwtAuthGuard)
  @Post("slice/:videoId")
  @ApiBearerAuth()
  @ApiHeader(SwaggerHeaderDefaults)
  @ApiBody({ type: () => [SliceVideoInputPayload] })
  @ApiResponse({ status: 200, description: 'Array of presigned S3 urls for the sliced videos.', type: String, isArray: true })
  @ApiResponse({ status: 403, description: 'Video not found.' })
  @ApiResponse({ status: 400, description: 'Bad Request / missing parameters' })
  @ApiBody({ type: () => SliceVideoInputPayload })
  public slice(@Param() { videoId }: SliceVideoInputParams, @Body() { markers, sourceBucket, destinationBucket }: SliceVideoInputPayload): Promise<string[]> {
    const s3 = new S3();
    return this.videoSvc.slice(videoId, markers, ({ start, duration }, stream) => s3.upload({
      Bucket: destinationBucket || 'sliced-video-clips',
      Key: `${videoId}/${videoId}_${start}+${duration}.mp4`,
      Body: stream.pipe()
    }).promise().then(({ Bucket, Key }) => s3.getSignedUrlPromise("getObject", { Bucket, Key })), sourceBucket);
  }
}
