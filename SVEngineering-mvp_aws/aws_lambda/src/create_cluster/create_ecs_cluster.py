import time
import boto3
from .cloudformation import cluster_template
import json

cf_client=boto3.client('cloudformation')
_template_body=json.dumps(cluster_template.template)
ec2_client=boto3.client('ec2')
ec2_resource=boto3.resource('ec2')
ecs_client=boto3.client('ecs')
kvs_client=boto3.client('kinesisvideo')
sqs_client=boto3.client('sqs')

def lambda_handler(event,context):
    user_id = event['queryStringParameters']['user_id']
    cf_stack_name='EC2ContainerService-cluster-'+str(user_id)
    waiter=cf_client.get_waiter('stack_create_complete')
    ecs_task_waiter=ecs_client.get_waiter('tasks_running')
    kvs_name=f'sportsVisio-{user_id}'
    sqs_queue_name=f's3-video-fragments-{user_id}.fifo'

    #Create Kinesis Video Stream
    kvs_client.create_stream(
        StreamName=kvs_name,
        DataRetentionInHours=24
    )
    print(f'Kinesis Video Stream created with name:{kvs_name} for user:{user_id}')

    #Create Video Fragments FIFO Queue
    sqs_client.create_queue(
        QueueName=sqs_queue_name,
        Attributes={
            'FifoQueue':'true',
            'MessageRetentionPeriod':'3600',
            'VisibilityTimeout':'30',
            'ReceiveMessageWaitTimeSeconds':'5',
            'ContentBasedDeduplication':'true',
            'DeduplicationScope':'queue',
            'FifoThroughputLimit':'perQueue'
        }
    )

    print(f'SQS FIFO Queue created for video fragments for user:{user_id}')

    kvs_stream='sportsVisio'
    sqs_queue='s3-video-fragments-events.fifo'

    try:
        #create ECS Cluster
        cluster_name='cluster-'+user_id
        resp=ecs_client.create_cluster(
            clusterName=cluster_name)

        #create CF stack
        resp=cf_client.create_stack(
            StackName=cf_stack_name,
            TemplateBody=_template_body,
            Parameters=[
                {
                    'ParameterKey': 'AsgMaxSize',
                    'ParameterValue': '1'
                },
                {
                    'ParameterKey': 'KeyName',
                    'ParameterValue': 'cliff_dev'
                },
                {
                    'ParameterKey': 'KvsStream',
                    'ParameterValue': kvs_name
                },
                {
                    'ParameterKey': 'SqsQueue',
                    'ParameterValue': sqs_queue_name
                },
                {
                    'ParameterKey': 'AutoAssignPublicIp',
                    'ParameterValue': 'true'
                },
                {
                    'ParameterKey': 'ConfigureDataVolume',
                    'ParameterValue': 'false'
                },
                {
                    'ParameterKey': 'ConfigureRootVolume',
                    'ParameterValue': 'true'
                },
                {
                    'ParameterKey': 'DeviceName',
                    'ParameterValue': '/dev/xvdcz'
                },
                {
                    'ParameterKey': 'EbsVolumeSize',
                    'ParameterValue': '22'
                },
                {
                    'ParameterKey': 'EbsVolumeType',
                    'ParameterValue': 'gp2'
                },
                {
                    'ParameterKey': 'EcsAmiId',
                    'ParameterValue': 'ami-091aa67fccd794d5f'
                },
                {
                    'ParameterKey': 'EcsClusterName',
                    'ParameterValue': cluster_name
                },
                {
                    'ParameterKey': 'EcsInstanceType',
                    'ParameterValue': 't2.micro'
                },
                {
                    'ParameterKey': 'IamRoleInstanceProfile',
                    'ParameterValue': 'arn:aws:iam::486882512119:instance-profile/ecsInstanceRole'
                },
                {
                    'ParameterKey': 'IsWindows',
                    'ParameterValue': 'false'
                },
                {
                    'ParameterKey': 'RootDeviceName',
                    'ParameterValue': '/dev/xvda'
                },
                {
                    'ParameterKey': 'RootEbsVolumeSize',
                    'ParameterValue': '30'
                },
                {
                    'ParameterKey': 'SecurityGroupId',
                    'ParameterValue': 'sg-80221a99'
                },
                {
                    'ParameterKey': 'SecurityIngressCidrIp',
                    'ParameterValue': '0.0.0.0/0'
                },
                {
                    'ParameterKey': 'SecurityIngressFromPort',
                    'ParameterValue': '80'
                },
                {
                    'ParameterKey': 'SecurityIngressToPort',
                    'ParameterValue': '80'
                },
                {
                    'ParameterKey': 'SpotAllocationStrategy',
                    'ParameterValue': 'diversified'
                },
                {
                    'ParameterKey': 'SubnetCidr1',
                    'ParameterValue': '10.0.0.0/24'
                },
                {
                    'ParameterKey': 'SubnetCidr2',
                    'ParameterValue': '10.0.1.0/24'
                },
                {
                    'ParameterKey': 'SubnetIds',
                    'ParameterValue': 'subnet-a1cb89c7,subnet-c2f968f3,subnet-2beea174,subnet-248b8f2a,subnet-995f17b8,subnet-c2a7b58f'
                },
                {
                    'ParameterKey': 'UseSpot',
                    'ParameterValue': 'false'
                },
                {
                    'ParameterKey': 'VpcAvailabilityZones',
                    'ParameterValue': 'us-east-1a,us-east-1b,us-east-1c,us-east-1d,us-east-1e,us-east-1f'
                },
                {
                    'ParameterKey': 'VpcCidr',
                    'ParameterValue': '10.0.0.0/16'
                },
                {
                    'ParameterKey': 'VpcId',
                    'ParameterValue': 'vpc-0c8a1471'
                },
            ]
        )

        waiter.wait(
            StackName=cf_stack_name,
            WaiterConfig={
                'Delay': 5,
                'MaxAttempts': 20
            }
        )

        instance_id=None
        instances = ec2_resource.instances.filter(
            Filters=[
                {
                    'Name':'instance-state-name',
                    'Values':['pending','running']
                }
            ]
        )
        for instance in instances:
            for tag in instance.tags:
                if tag["Key"] == 'Name':
                    if '-'.join(tag["Value"].split("-")[2:])=='cluster-'+user_id:
                        instance_id=instance.id
                        break

        instance = ec2_resource.Instance(instance_id)
        instance.wait_until_running()

        print(f'ECS Cluster created for User:{user_id} with one ec2 running ID:{instance_id}')

        _max_limit = 10
        delay = 5
        _running_instances = 0
        i = 0
        while _running_instances < 1 and i < _max_limit:
            resp = ecs_client.list_container_instances(
                cluster=cluster_name,
                status='ACTIVE'
            )
            _running_instances = len(resp['containerInstanceArns'])
            time.sleep(delay)
            i += 1

        if _running_instances < 1:
            raise Exception(f'Failed to run container Instance on cluster {cluster_name}')

        #Run KVS Consumer Task

        resp=ecs_client.run_task(
            cluster=cluster_name,
            launchType='EC2',
            taskDefinition='KVSConsumer',
            count=1,
            overrides={
                'containerOverrides':[
                    {
                        'name':'kvs-consumer',
                        'environment':[
                            {
                                'name':'kvs_stream',
                                'value':kvs_name
                            },
                            {
                                'name':'sqs_queue',
                                'value':sqs_queue_name
                            }
                        ]
                    }
                ]
            }
        )
        kvs_consumer_task_id=resp['tasks'][0]['taskArn']

        #Run Full Video task
        resp = ecs_client.run_task(
            cluster=cluster_name,
            launchType='EC2',
            taskDefinition='GetFullVideo',
            count=1,
            overrides={
                'containerOverrides': [
                    {
                        'name':'fragments-processing',
                        'environment': [
                            {
                                'name': 'kvs_stream',
                                'value': kvs_name
                            },
                            {
                                'name': 'sqs_queue',
                                'value': sqs_queue_name
                            }
                        ]
                    }
                ]
            }
        )
        full_video_task_id = resp['tasks'][0]['taskArn']

        ecs_task_waiter.wait(
            cluster=cluster_name,
            tasks=[
                kvs_consumer_task_id,
                full_video_task_id
            ],
            WaiterConfig={
                'Delay': 1,
                'MaxAttempts': 20
            }
        )

        print('ECS Tasks running - successful')
        print('Infra setup is complete')

    except Exception as ex:
        print('Exception: '+str(ex))


