import math
import boto3
import cv2
import os
import urllib
import datetime
import json
import random

s3_client = boto3.client('s3')
sagemaker_client=boto3.client('sagemaker-runtime')
dynamo_db_resource=boto3.resource('dynamodb')
sqs_client = boto3.resource('sqs')

shots=['shot1','shot2','shot3','shot4']

def lambda_handler(event,context):
    bucket=event['Records'][0]['s3']['bucket']['name']
    _queue = sqs_client.get_queue_by_name(QueueName=os.environ.get("sqs_queue"))
    key=urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    producer_ts=str(key).split('/')[-1].replace(".mp4","")
    fragment_number=str(key).split('/')[2]
    video_id=str(key).split('/')[1]
    producer_ts=datetime.datetime.strptime(producer_ts, '%Y-%m-%d %H:%M:%S.%f')
    frame_ts=producer_ts
    time_delta=datetime.timedelta(milliseconds=500)

    url = s3_client.generate_presigned_url(ClientMethod='get_object', Params={'Bucket': bucket,
                                      'Key': key})
    cap = cv2.VideoCapture(url)
    timeRate = 0.5
    c = 1

    while (True):
        ret, frame = cap.read()
        FPS = cap.get(5)
        if ret:
            # Because the number of frames obtained by cap.get(5) is not an integer,
            # it needs to be rounded up (int for rounding down, round for rounding up,
            # ceil( of math module for rounding up) ) Method)
            frameRate = math.floor(float(
                FPS * timeRate))
            if (c % frameRate == 0 or c==1):
                print("Start to capture video:" + str(c) + "frame")
                # Here you can do some operations: display the captured frame picture,
                # save the captured frame to the local

                # cv2.imwrite(str(c) + '.jpeg',
                #             frame)  # here is to save the captured image locally

                frame_bytes = cv2.imencode('.jpeg', frame)[1].tobytes()

                #Getting inference data from sagemaker
                # resp=sagemaker_client.invoke_endpoint(
                #     EndpointName=os.environ.get("sagemaker_endpoint"),
                #     Body=frame_bytes,
                #     ContentType='image/jpeg'
                # )
                # sagemaker_output=resp['Body'].read().decode("utf-8")

                annotation = random.choice(shots)

                #Save frame timestamp and sagemaker model output to dynamodb
                table = dynamo_db_resource.Table(os.environ.get("dynamo_db_table"))
                ts=frame_ts.strftime('%Y-%m-%d %H:%M:%S.%f')
                table.put_item(
                    Item={
                        'VideoID': video_id,
                        'ProducerTimestamp': ts,
                        'FragmentNumber':fragment_number,
                        'Annotation': annotation,
                        'S3Link':'',
                        'ClipStartTime':'',
                        'ClipEndTime':''
                    }
                )
                print('Annotation data saved to dynamodb')
                data = {"id": video_id,
                        "producer_timestamp": ts,
                        'annotation':annotation}
                _queue.send_message(
                    MessageBody=json.dumps(data),
                    MessageGroupId=video_id
                )

                frame_ts=frame_ts+time_delta

            c += 1
            cv2.waitKey(0)
        else:
            print("All frames have been saved")
            break