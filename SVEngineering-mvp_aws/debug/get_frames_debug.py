from aws_lambda.src import get_annotation_data
import os

if __name__=="__main__":
    os.environ["dynamo_db_table"] = "HighlightsData"
    os.environ["sagemaker_endpoint"] = "object-detection-2021-06-21-17-15-03-833"
    os.environ["sqs_queue"] = "GetHighlightsEvents.fifo"
    event={
        "Records":[
            {
                's3':{
                    'bucket':{
                        'name':'kvs-video-fragments'
                    },
                    'object':{
                        'key':'sportsVisio/vmx-7000/91343852333181506688891460389735156091285336795/2021-07-10 05:50:42.197000.mp4'
                    }
                }
            }
        ]

    }
    get_annotation_data.lambda_handler(event,context=None)