from ecs.get_highlights.src import get_highlights
import os

if __name__=="__main__":
    os.environ["s3_output_bucket"] = "video-highlights"
    os.environ["sqs_queue"]="GetHighlightsEvents.fifo"
    os.environ["kvs_stream"] = "sportsVisio"
    os.environ["dynamo_db_table"] = "HighlightsData"
    os.environ["region"] = "us-east-1"

    get_highlights.get_highlights()