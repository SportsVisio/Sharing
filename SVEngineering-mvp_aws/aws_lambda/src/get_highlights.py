import json

import boto3
from boto3.dynamodb.conditions import Key
from boto3.dynamodb.conditions import Attr
import os

_dynamo_db_resource=boto3.resource('dynamodb')
s3_client=boto3.client('s3')

def lambda_handler(event,context):
    video_id= event['queryStringParameters']['video_id']
    annotation= event['queryStringParameters']['annotation']

    response_object = {}
    try:
        highlights_table=_dynamo_db_resource.Table(os.environ.get("dynamo_db_table"))
        response = highlights_table.query(
            ScanIndexForward=False,
            ConsistentRead=True,
            KeyConditionExpression=Key('VideoID').eq(video_id),
            FilterExpression=Attr('Annotation').eq(annotation))

        video_highlights=[]

        for resp in response['Items']:
            highlight_dict={}

            highlight_dict['video_id']=resp['VideoID']
            highlight_dict['producer_timestamp']=resp['ProducerTimestamp']
            highlight_dict['clip_start_time']=resp['ClipStartTime']
            highlight_dict['clip_end_time']=resp['ClipEndTime']
            highlight_dict['annotation']=resp['Annotation']

            s3_key='/'.join(resp['S3Link'].split("s3://")[1].split('/')[1:])
            highlight_presigned_url=s3_client.generate_presigned_url('get_object',
                                             Params={'Bucket': os.environ.get(
                                                 "video_highlights_bucket"),
                                                 'Key': s3_key},
                                             ExpiresIn=3600)
            highlight_dict['s3_url']=highlight_presigned_url

            video_highlights.append(highlight_dict)

        response_object['statusCode'] = 200
        response_object['headers'] = {}
        response_object['headers']['Content-Type'] = 'application/json'
        response_object['body'] = json.dumps({'video_highlights': video_highlights})

    except Exception as ex:
        print('Exception: '+str(ex))
        response_object['statusCode'] = 500
        response_object['headers'] = {}
        response_object['headers']['Content-Type'] = 'application/json'
        response_object['body'] = json.dumps({'message': 'Internal Server Error'})

    return response_object
