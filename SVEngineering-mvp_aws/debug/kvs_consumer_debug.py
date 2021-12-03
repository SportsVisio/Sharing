from src.kinesisvideo.continuous_consumer import ContinousConsumer
import os

if __name__=="__main__":
    os.environ["kvs_stream"]='sportsVisio'
    os.environ["checkpointing_table"]='KinesisCheckpointing'
    os.environ["sqs_queue"]="s3-video-fragments-events.fifo"
    os.environ["s3_bucket"]="kvs-video-fragments"
    consumer = ContinousConsumer()
    consumer.consume()

