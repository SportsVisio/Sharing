from aws_lambda.src import get_playback_stream
import os

if __name__=="__main__":
    os.environ["stream_name"] = "sportsVisio_video"
    event={
    "queryStringParameters":{
        "startTime":"21/06/21 19:00:19"
    }
}
    get_playback_stream.lambda_handler(event=event,context=None)