import boto3
import json
import os
import subprocess
import shlex
import string
import random

s3=boto3.resource('s3',region_name='us-east-1')

s3_client=boto3.client('s3',region_name='us-east-1')

kv_client=boto3.client('kinesisvideo',region_name='us-east-1')

_sqs_client = boto3.resource('sqs',region_name='us-east-1')


def get_random_string(length):
    letters = string.ascii_lowercase
    result_str = ''.join(random.choice(letters) for i in range(length))
    print("Random string of length", length, "is:", result_str)
    return result_str

def combine_fragments():
    _queue = _sqs_client.get_queue_by_name(QueueName=os.environ.get("sqs_queue"))
    input_bucket = s3.Bucket(os.environ.get("s3_input_bucket"))
    output_bucket = s3.Bucket(os.environ.get("s3_output_bucket"))
    stream_name = os.environ.get("kvs_stream")
    while True:
        fragment_events = _queue.receive_messages(
            MaxNumberOfMessages=10,
            WaitTimeSeconds=10
        )
        print(str(len(fragment_events))+' sqs events found')

        video_groups={}
        sqs_events=[]
        for event in fragment_events:
            body = json.loads(event.body)

            sqs_events.append({'Id':body['id'],'ReceiptHandle':event.receipt_handle})

            if body['id'] not in video_groups:
                video_groups[body['id']]=[]
                video_groups[body['id']].append(body['s3_key'])
            else:
                video_groups[body['id']].append(body['s3_key'])

        for id,s3_keys in video_groups.items():
            video_id=id
            output_key = video_id + '.mp4'
            base_url = os.path.dirname(os.path.realpath(__file__)) + '/'
            file_path = base_url + 'list.txt'
            fragment_file_paths=[]

            for key in s3_keys:
                fragment_s3_key = key
                print('Getting presigned url for '+str(fragment_s3_key))


                fragment_presigned_url = s3_client.generate_presigned_url('get_object',
                                                                          Params={'Bucket': os.environ.get(
                                                                              "s3_input_bucket"),
                                                                                  'Key': fragment_s3_key},
                                                                          ExpiresIn=3600)

                # Tranform fragment timestamp and save locally
                frag_file_path = base_url + get_random_string(6) + '.mp4'
                ffmpeg_cmd = "ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i \"" \
                             + fragment_presigned_url + "\" -video_track_timescale 60000 -c:v libx264 \"" + frag_file_path + "\""
                command1 = shlex.split(ffmpeg_cmd)
                subprocess.run(command1)

                fragment_file_paths.append(frag_file_path)

            objs = list(output_bucket.objects.filter(Prefix=output_key))
            video_presigned_url=''
            if any([w.key == output_key for w in objs]):
                video_presigned_url = s3_client.generate_presigned_url('get_object',
                                                                       Params={
                                                                           'Bucket': os.environ.get("s3_output_bucket"),
                                                                           'Key': output_key},
                                                                       ExpiresIn=3600)
                print('Uploading first video fragment successfully')

            with open(file_path, 'w') as outfile:
                if video_presigned_url!='':
                    outfile.write("file '" + video_presigned_url + "'\n")
                for file in fragment_file_paths:
                    outfile.write("file '" + file + "'\n")

            output_file_path = base_url + get_random_string(6) + '.mp4'
            ffmpeg_cmd = "ffmpeg -f concat -safe 0 -protocol_whitelist file,http,https,tcp,tls,crypto -i \"" + base_url + "\"list.txt " \
                                                                                                                          "-c copy \"" + output_file_path + "\""
            command1 = shlex.split(ffmpeg_cmd)
            p1 = subprocess.run(command1)

            s3.meta.client.upload_file(output_file_path, os.environ.get("s3_output_bucket"), output_key)


            if os.path.exists(file_path):
                os.remove(file_path)
                print("File " + file_path + " removed")

            for fragment_file in fragment_file_paths:
                if os.path.exists(fragment_file):
                    os.remove(fragment_file)
                    print("Fragment file " + fragment_file + " removed")

            if os.path.exists(output_file_path):
                os.remove(output_file_path)
                print("Fragment file " + output_file_path + " removed")

            print('Fragments uploaded for video '+str(video_id))

        for event in sqs_events:
            _queue.delete_messages(
                Entries=[event]
            )
            print('Sqs event deleted successfully')


if __name__=="__main__":
    combine_fragments()