from ecs.full_video.src import get_full_video
import os

if __name__=="__main__":
    os.environ["transcoder_pipeline_id"]="1624908671671-g3aqg6"
    os.environ["s3_input_bucket"] = "kvs-video-fragments"
    os.environ["s3_output_bucket"] = "sportsvisio-transcoded-videos"
    os.environ["sqs_queue"]="s3-video-fragments-events.fifo"
    os.environ["kvs_stream"] = "sportsVisio"

    get_full_video.combine_fragments()