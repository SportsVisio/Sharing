import json
import boto3
from botocore.exceptions import ClientError
import os

kvs = boto3.client("kinesisvideo")


def lambda_handler(event, context):
    print(event)

    kvs_stream = os.environ.get("stream_name")

    endpoint = get_hls_session_url(kvs_stream)

    hls_client = boto3.client('kinesis-video-archived-media', endpoint_url=endpoint)

    response_object = {}

    try:

        streaming_session_url = hls_client.get_hls_streaming_session_url(
            StreamName=kvs_stream,
            PlaybackMode='LIVE',
            HLSFragmentSelector={
                'FragmentSelectorType': 'PRODUCER_TIMESTAMP',
            },
            ContainerFormat='FRAGMENTED_MP4',
            Expires=3600,
        )['HLSStreamingSessionURL']

        print(streaming_session_url)

        response_object['statusCode'] = 200
        response_object['headers'] = {}
        response_object['headers']['Content-Type'] = 'application/json'
        response_object['body'] = json.dumps({'live_streaming_url': streaming_session_url})

    except ClientError as ex:
        response_object['statusCode'] = ex.response['ResponseMetadata']['HTTPStatusCode']
        response_object['headers'] = {}
        response_object['headers']['Content-Type'] = 'application/json'
        response_object['body'] = json.dumps({'message': ex.response['Error']['Message']})

    print(response_object)
    return response_object


def get_hls_session_url(kvs_stream):
    url = kvs.get_data_endpoint(
        APIName="GET_HLS_STREAMING_SESSION_URL",
        StreamName=kvs_stream)['DataEndpoint']

    return url