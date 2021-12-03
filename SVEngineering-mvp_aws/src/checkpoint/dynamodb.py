import boto3
from boto3.dynamodb.conditions import Key
import datetime

class Dynamo:
    '''
    This class acts as a client for DynamoDB for checkpointing fragment numbers
    '''
    def __init__(self,table_name,kvs_name):
        self._table_name=table_name
        self._kvs_name=kvs_name
        self._client=self.get_client()
        self._table=self._client.Table(self._table_name)

    def get_client(self):
        return boto3.resource('dynamodb',region_name='us-east-1')

    def create_table_if_not_exists(self,name):
        raise NotImplementedError

    def check_if_table_exists(self):
        raise NotImplementedError

    def get_last_checkpoint_item(self):
        print('Getting last checkpointed fragment number')
        response=self._table.query(
        Limit=1,
        ScanIndexForward=False,
        ConsistentRead=True,
        KeyConditionExpression=Key('kv_stream').eq(self._kvs_name))
        return (response['Items'][0]['fragment_number'] if len(response['Items'])>0 else None)

    def checkpoint_item(self,fragment_num):
        print('Checkpointing fragment number')
        curr_timestamp=str(datetime.datetime.now())
        self._table.put_item(
            Item={
                'kv_stream':self._kvs_name,
                'timestamp':curr_timestamp,
                'fragment_number':fragment_num
            }
        )