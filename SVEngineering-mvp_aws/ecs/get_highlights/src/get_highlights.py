import boto3
import json
import os
import datetime

s3_client=boto3.client('s3',region_name=os.environ.get("region"))

_sqs_client = boto3.resource('sqs',region_name=os.environ.get("region"))

kvs_client=boto3.client('kinesisvideo',region_name=os.environ.get("region"))

dynamo_db_client = boto3.client('dynamodb',region_name=os.environ.get("region"))

time_delta=datetime.timedelta(milliseconds=5000)

def get_highlights():
    _queue = _sqs_client.get_queue_by_name(QueueName=os.environ.get("sqs_queue"))
    kvs_name = os.environ.get("kvs_stream")

    kvs_endpoint=kvs_client.get_data_endpoint(StreamName=kvs_name,
                      APIName='GET_CLIP')['DataEndpoint']

    kvam = boto3.client('kinesis-video-archived-media',
                                endpoint_url=kvs_endpoint,region_name=os.environ.get("region"))


    while True:
        highlight_events = _queue.receive_messages(
            MaxNumberOfMessages=10,
            WaitTimeSeconds=5
        )

        for event in highlight_events:
            body = json.loads(event.body)
            video_id = body['id']
            original_producer_ts=body['producer_timestamp']
            producer_timestamp = original_producer_ts.split('.')[0]
            annotation = body['annotation']
            producer_timestamp = datetime.datetime.strptime(producer_timestamp, '%Y-%m-%d %H:%M:%S')
            try:
                start_time=(producer_timestamp-time_delta)-datetime.timedelta(hours=5)
                end_time=(producer_timestamp+time_delta)-datetime.timedelta(hours=5)

                # last_hour_date_time = datetime.datetime.utcnow() - datetime.timedelta(hours=2)
                # start_time=last_hour_date_time.strftime('%Y-%m-%d %H:%M:%S')
                #
                # last_hour_date_time = datetime.datetime.utcnow()
                # end_time=last_hour_date_time.strftime('%Y-%m-%d %H:%M:%S')

                resp=kvam.get_clip(
                    StreamName=kvs_name,
                    ClipFragmentSelector={
                        'FragmentSelectorType':'PRODUCER_TIMESTAMP',
                        'TimestampRange': {
                            'StartTimestamp': start_time,
                            'EndTimestamp': end_time
                        }
                    }
                )

                output_key=video_id+'/'+annotation+'/'+str(producer_timestamp)+'.mp4'
                s3_client.put_object(Bucket=os.environ.get("s3_output_bucket"),Key=output_key,Body=resp['Payload'].read())
                s3_object_uri='s3://'+os.environ.get("s3_output_bucket")+'/'+output_key

                dynamo_db_client.update_item(
                    TableName=os.environ.get("dynamo_db_table"),
                    Key={
                        'VideoID':{
                            'S':video_id
                        },
                        'ProducerTimestamp':{
                            'S':original_producer_ts
                        }
                    },
                    AttributeUpdates={
                        'S3Link':{
                            'Value':{'S':s3_object_uri},
                            'Action': 'PUT'
                        },
                        'ClipStartTime':{
                            'Value':{'S':str(start_time)},
                            'Action': 'PUT'
                        },
                        'ClipEndTime':{
                            'Value':{'S':str(end_time)},
                            'Action': 'PUT'
                        }
                    }
                )

            except Exception as ex:
                print(ex)
                print('Error getting highlight for video '+video_id+' at timestamp: '+str(producer_timestamp))

            _queue.delete_messages(
                Entries=[
                    {
                        'Id':video_id,
                        'ReceiptHandle':event.receipt_handle
                    }
                ]
            )


if __name__=="__main__":
    get_highlights()