from __future__ import print_function
import base64
import json
import boto3
import os
import datetime
import time
from botocore.exceptions import ClientError

# Lambda function is written based on output from an Amazon SageMaker example:
# https://github.com/awslabs/amazon-sagemaker-examples/blob/master/introduction_to_amazon_algorithms/object_detection_pascalvoc_coco/object_detection_image_json_format.ipynb
object_categories = ['person', 'bicycle', 'car', 'motorbike', 'aeroplane', 'bus', 'train', 'truck', 'boat',
                     'traffic light', 'fire hydrant', 'stop sign', 'parking meter', 'bench', 'bird', 'cat', 'dog',
                     'horse', 'sheep', 'cow', 'elephant', 'bear', 'zebra', 'giraffe', 'backpack', 'umbrella', 'handbag',
                     'tie', 'suitcase', 'frisbee', 'skis', 'snowboard', 'sports ball', 'kite', 'baseball bat',
                     'baseball glove', 'skateboard', 'surfboard', 'tennis racket', 'bottle', 'wine glass', 'cup',
                     'fork', 'knife', 'spoon', 'bowl', 'banana', 'apple', 'sandwich', 'orange', 'broccoli', 'carrot',
                     'hot dog', 'pizza', 'donut', 'cake', 'chair', 'sofa', 'pottedplant', 'bed', 'diningtable',
                     'toilet', 'tvmonitor', 'laptop', 'mouse', 'remote', 'keyboard', 'cell phone', 'microwave', 'oven',
                     'toaster', 'sink', 'refrigerator', 'book', 'clock', 'vase', 'scissors', 'teddy bear', 'hair drier',
                     'toothbrush']
threshold = 0.15

def lambda_handler(event, context):
    for record in event['Records']:
        payload = base64.b64decode(record['kinesis']['data'])
        # Get Json format of Kinesis Data Stream Output
        result = json.loads(payload)

        # Get FragmentMetaData
        fragment = result['fragmentMetaData']
        # Extract Fragment ID and Timestamp
        frag_num = fragment[17:-1].split(",")[0].split("=")[1]
        producer_ts = datetime.datetime.fromtimestamp(float(fragment[17:-1].split(",")[2].split("=")[1]) / 1000)
        producer_ts = producer_ts.strftime("%m-%d-%Y,%H:%M:%S")
        print("fragment: " + fragment)

        # Get FrameMetaData
        frame = result['frameMetaData']
        print("frame: " + frame)
        # Get StreamName
        streamName = result['streamName']
        print("streamName: " + streamName)
        # Get SageMaker response in Json format
        sageMakerOutput = json.loads(base64.b64decode(result['sageMakerOutput']))
        print("sagemaker raw output: " + str(sageMakerOutput))

        # Print different detected objects with highest probability
        predictedList = sageMakerOutput['prediction']
        foundObjects = set(map(lambda x: x[0], predictedList))
        for foundObject in foundObjects:
            filtered = [x[0:2] for x in predictedList if x[0] == foundObject and x[1] > threshold]
            if len(filtered) > 0:
                highestConfidenceDetection = max(filtered, key=lambda y: y[1])
                print("detected object: " + object_categories[
                    int(highestConfidenceDetection[0])] + ", with confidence: " + str(highestConfidenceDetection[1]))

        detections = {}
        detections['StreamName'] = streamName
        detections['fragmentMetaData'] = fragment
        detections['frameMetaData'] = frame
        detections['sageMakerOutput'] = sageMakerOutput

        #Get KVS fragments and write Sagemaker output and corresponding fragments numbers to dynamoDB
        user="test_user"
        db = boto3.resource('dynamodb')
        table = db.Table(os.environ.get("dynamo_db_table"))
        table.put_item(
            Item={
                'user': user,
                'producer_timestamp': producer_ts,
                'sagemaker_output': json.dumps(detections),
                'fragment_number': frag_num
            }
        )

        # Get KVS fragment and write .webm file and detection details to S3
        s3 = boto3.client('s3')
        kv = boto3.client('kinesisvideo')
        get_ep = kv.get_data_endpoint(StreamName=streamName, APIName='GET_MEDIA_FOR_FRAGMENT_LIST')
        kvam_ep = get_ep['DataEndpoint']
        kvam = boto3.client('kinesis-video-archived-media', endpoint_url=kvam_ep)
        getmedia = kvam.get_media_for_fragment_list(
            StreamName=streamName,
            Fragments=[frag_num])
        base_key = streamName + "/" + producer_ts
        webm_key = base_key + '.webm'
        text_key = base_key + '.txt'
        s3.put_object(Bucket=os.environ.get("bucket"), Key=webm_key, Body=getmedia['Payload'].read())

        print(
            f"Detection details and fragment stored in the dynamodb for user:{user} with producer timestamp: {producer_ts}")


    return 'Successfully processed {} records.'.format(len(event['Records']))
