import { Injectable } from '@nestjs/common';
import { S3, KinesisVideo, KinesisVideoArchivedMedia } from "aws-sdk";
import { GetDataEndpointInput } from "aws-sdk/clients/kinesisvideo";
import { GetHLSStreamingSessionURLInput } from "aws-sdk/clients/kinesisvideoarchivedmedia";
import { SliceVideoMarker } from "./video.classes";
import * as ffmpeg from "fluent-ffmpeg";
import { pipeline } from "stream";
import { path as ffmpegPath } from "@ffmpeg-installer/ffmpeg";
import { logger } from "../common/logger";
import { createWriteStream, unlinkSync } from "fs";

const Bucket = process.env.TRANSCODED_S3_BUCKET || "sportsvisio-transcoded-videos";
type SliceVideoCallback = (marker: SliceVideoMarker, stream: ffmpeg.FfmpegCommand) => Promise<any>;

@Injectable()
export class VideoService {
  private s3 = new S3();
  private k = new KinesisVideo();

  constructor(
  ) {
  }

  public async getPresignedFullVideoUrl(videoId: string): Promise<string> {
    const params = {
      Bucket,
      Key: `${videoId}.mp4`
    };
    return this.s3.getObject(params).promise().then(obj => {
      if (!obj || !obj.Body) throw new Error("Unable to retrieve video, or video is empty.");
      return this.s3.getSignedUrl("getObject", params);
    });
  }

  public getDataEndpoint(streamName: string): Promise<string> {
    const params: GetDataEndpointInput = {
      APIName: "GET_HLS_STREAMING_SESSION_URL",
      StreamName: streamName
    };
    return this.k.getDataEndpoint(params).promise().then(({ DataEndpoint: endpoint }) => endpoint);
  }

  public async getHlsUrl(streamName: string, options?: Partial<GetHLSStreamingSessionURLInput>): Promise<string> {
    const defaultOptions = {
      StreamName: streamName,
      PlaybackMode: "LIVE",
      HLSFragmentSelector: {
        FragmentSelectorType: "PRODUCER_TIMESTAMP",
      },
      ContainerFormat: "FRAGMENTED_MP4",
      Expires: 3600
    };

    return (new KinesisVideoArchivedMedia({
      endpoint: await this.getDataEndpoint(streamName)
    })).getHLSStreamingSessionURL({
      ...defaultOptions,
      ...options
    }).promise().then(({ HLSStreamingSessionURL }) => HLSStreamingSessionURL);
  }

  public async slice(videoId: string, markers: SliceVideoMarker[], segmentCallback: SliceVideoCallback, BaseBucket?: string): Promise<any> {
    const fileName = `${videoId}.mp4`;
    const filePath = `/tmp/${fileName}`;

    logger.info(`Fetching ${fileName} from S3 ...`);

    // wait for the s3 / write streams to finish
    await new Promise((resolve, reject) => {
      const params = {
        Bucket: BaseBucket || Bucket,
        Key: fileName
      };
      pipeline(
        this.s3.getObject(params).createReadStream(),
        createWriteStream(filePath),
        (err) => {
          logger.info("Local write complete");
          if (err) reject(err);
          else resolve(void 0);
        }
      );
    });

    return Promise.all(
      markers.map((marker) => new Promise((resolve, reject) => {
        const { start, duration } = marker;

        ffmpeg.setFfmpegPath(ffmpegPath);

        logger.info(`Processing: ${fileName}`);

        const stream = ffmpeg()
          .input(filePath)
          // .withVideoCodec('libx264')
          // .fps(24)
          .withVideoCodec('copy')
          .withAudioCodec('copy')
          .toFormat("mp4")
          // .format("mp4")
          .outputOptions([
            "-pix_fmt yuv420p",
            '-movflags frag_keyframe+empty_moov',
            '-movflags +faststart'
          ])          
          .setStartTime(start)
          .setDuration(duration)
          .on("end", () => {
            logger.info(`Finished marker segment encoding: ${start}+${duration}`);
          })
          .on("error", (err) => {
            logger.error(err);
            reject();
          });

        segmentCallback(marker, stream)
          .then(data => resolve(data))
          .catch(err => reject(err));
      }))
    ).finally(() => {
      logger.info(`Cleanup: ${fileName}`);
      unlinkSync(filePath);
    });
  }
}
