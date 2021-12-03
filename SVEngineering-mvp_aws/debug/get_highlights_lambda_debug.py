from aws_lambda.src.get_highlights import lambda_handler
import os

if __name__=="__main__":
    os.environ["dynamo_db_table"]="HighlightsData"
    os.environ["video_highlights_bucket"] = "video-highlights"
    event = {
        "queryStringParameters": {
            "video_id": "vmx-7000",
            "annotation": "shot2"
        }
    }
    lambda_handler(event,None)