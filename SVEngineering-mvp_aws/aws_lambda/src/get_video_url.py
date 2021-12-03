import json
import boto3
from botocore.exceptions import ClientError
import os

s3 = boto3.resource('s3')
s3_client = boto3.client('s3')


def lambda_handler(event, context):
    print(event)
    video_id = event['queryStringParameters']['id']
    s3_key = video_id + '.mp4'

    _bucket = s3.Bucket(os.environ.get("s3_bucket"))

    objs = list(_bucket.objects.filter(Prefix=s3_key))

    response_object = {}

    if any([w.key == s3_key for w in objs]):

        _presigned_url = s3_client.generate_presigned_url('get_object',
                                                          Params={'Bucket': os.environ.get("s3_bucket"),
                                                                  'Key': s3_key},
                                                          ExpiresIn=3600)

        response_object['statusCode'] = 200
        response_object['headers'] = {}
        response_object['headers']['Content-Type'] = 'application/json'
        response_object['body'] = json.dumps({'message': 'success',
                                              'url': _presigned_url})

    else:
        response_object['statusCode'] = 404
        response_object['headers'] = {}
        response_object['headers']['Content-Type'] = 'application/json'
        response_object['body'] = json.dumps({'message': f'Video not found, id:{video_id}'})

    print(response_object)
    return response_object