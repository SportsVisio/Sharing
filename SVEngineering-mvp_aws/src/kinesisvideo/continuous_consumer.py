import re
import time
import os
import sys
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../..')))
from base import KinesisVideoBase
from src.destination.s3 import S3Client
from src.checkpoint.dynamodb import Dynamo
from src.utils.matroska_parser import Ebml,MatroskaTags
from datetime import datetime
import asyncio
from pprint import pprint
import aioboto3
import threading
import boto3
import json

current_path=os.path.dirname(os.path.realpath(__file__))
prj_root=current_path+'/../../'

class ContinousConsumer(KinesisVideoBase):
    '''
    This class coninuously consumes available fragments from kinesis video stream
    '''

    def __init__(self):
        super(ContinousConsumer,self).__init__(os.environ.get("kvs_stream"))
        self._s3_client=S3Client()
        self._dynamodb_client=Dynamo(os.environ.get("checkpointing_table"),os.environ.get("kvs_stream"))
        self._sqs_client = boto3.resource('sqs',region_name='us-east-1')
        self._queue = self._sqs_client.get_queue_by_name(QueueName=os.environ.get("sqs_queue"))
        self._contiuation_token=None

    def consume(self):
        while True:
            fragment=self.get_fragment()
            #print(fragment)


    def get_fragment(self):

        last_checkpointed_fragment_number=self._dynamodb_client.get_last_checkpoint_item()

        if last_checkpointed_fragment_number!=None:
            fragment=self._media_client.get_media(
                StreamName=self._kinesis_video_stream,
                StartSelector={
                    'StartSelectorType':'FRAGMENT_NUMBER',
                    'AfterFragmentNumber':last_checkpointed_fragment_number
                }
            )
        else:
            fragment = self._media_client.get_media(
                StreamName=self._kinesis_video_stream,
                StartSelector={
                    'StartSelectorType': 'EARLIEST'
                }
            )

        content=fragment['Payload'].read()

        if len(content)>0:

            fragments=self.get_fragments(content)

            last_fragment_number=self.get_fragment_number(Ebml(fragments[-1], MatroskaTags).parse())

            fragment_objects=[]

            for fragment in fragments:
                producer_timestamp = self.get_producer_timestamp(str(fragment))
                fragment_number = self.get_fragment_number(Ebml(fragment, MatroskaTags).parse())


                fragment_objects.append({'producer_timestamp':producer_timestamp,
                                         'fragment_number':fragment_number,
                                         'fragment':fragment})

            t = threading.Thread(target=self.process_chunk, args=(fragment_objects,))
            t.start()

            # self._fragment_number=self.get_fragment_number(matroska_tags)

            # _mkv_tags_payload = str(content[-200:])
            #
            # self._contiuation_token=self.get_continuation_token(_mkv_tags_payload)

            self._dynamodb_client.checkpoint_item(fragment_num=last_fragment_number)

            return fragment

    def process_chunk(self,fragment_objects):
        asyncio.run(self.prepare_fragment(fragment_objects))

    async def prepare_fragment(self,fragment_objects):
        events = list()
        s = time.perf_counter()
        async with aioboto3.client("s3",region_name='us-east-1') as s3:
            video_id = 'vmx-7000'
            for obj in fragment_objects:
                s3_key = self._kinesis_video_stream +'/'+video_id+'/'+ str(obj['fragment_number'])+'/' + str(obj['producer_timestamp']) + '.mp4'
                events.append(self._s3_client.upload_to_aws(s3,os.environ.get("s3_bucket"), s3_key, obj['fragment']))

            res = await asyncio.gather(*events)

            for obj in fragment_objects:
                s3_key = self._kinesis_video_stream + '/' + video_id + '/' + str(obj['fragment_number']) + '/' + str(
                    obj['producer_timestamp']) + '.mp4'
                data = {"id": video_id,
                        "s3_key":s3_key}
                self._queue.send_message(
                    MessageBody=json.dumps(data),
                    MessageGroupId=video_id
                )

        pprint(res)
        elapsed = time.perf_counter() - s
        print(f"{__file__} executed in {elapsed:0.2f} seconds.")

    def get_fragments(self,fragments):
        fragments=fragments.split(b'\x1aE\xdf\xa3\xa3B\x86\x81')
        filtered_fragments=fragments[1:]

        modified_fragments=[]
        for fragment in filtered_fragments:
            modified_fragments.append(b'\x1aE\xdf\xa3\xa3B\x86\x81'+fragment)

        return modified_fragments

    def get_producer_timestamp(self,fragment):
        pattern=re.compile("(AWS_KINESISVIDEO_PRODUCER_TIMESTAMPD\S+)(\d*\.?\d*)\S*(x1fC)")
        matches = re.findall(pattern,fragment)
        if len(matches)>0:
            producer_timestamp=str(matches[0][0]).replace("AWS_KINESISVIDEO_PRODUCER_TIMESTAMPD\\x87\\x10\\x00\\x00\\x0e","")\
                .strip("\\").replace(".","")
            secs, millis = divmod(int(producer_timestamp), 1000)
            producer_timestamp = datetime.fromtimestamp(secs).replace(microsecond=millis * 1000)
            return producer_timestamp
        else:
            print("No Producer timestamp found")
            return None

    def get_fragment_number(self,mkv_tags):
        for tag in mkv_tags['Segment'][0]['Tags'][0]['Tag'][0]['SimpleTag']:
            if tag['TagName'][0]=='AWS_KINESISVIDEO_FRAGMENT_NUMBER':
                return tag['TagString'][0]
        return None

    def get_continuation_token(self,mkv_payload):
        pattern = re.compile("(AWS_KINESISVIDEO_CONTINUATION_TOKEN\S+\/\d+(?=\'))")
        matches = re.findall(pattern, mkv_payload)
        if len(matches)>0:
            continutation_token = str(matches[0]).replace(
                "AWS_KINESISVIDEO_CONTINUATION_TOKEND\\x87\\x10\\x00\\x00/", '').strip("'")
            return continutation_token
        else:
            print('No continuation token found')
            return None


if __name__=='__main__':
    consumer=ContinousConsumer()
    consumer.consume()