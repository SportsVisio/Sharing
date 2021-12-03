import boto3
import aioboto3

class S3Client:
    '''
    This class acts as a client for s3
    '''
    def __init__(self):
        self._client=self.get_client()

    def get_client(self):
        return aioboto3.client('s3',region_name='us-east-1')

    def put_object(self,bucket_name,key,body):
        '''
        :param bucket_name: S3 bucket name
        :param key: Key for s3 object
        :param body: Content of the object
        :return:
        '''
        self._client.put_object(Bucket=bucket_name,
                                Key=key,
                                Body=body)

    async def upload_to_aws(self, s3, bucket_name, key, body):
        try:
            await s3.put_object(Bucket=bucket_name, Key=key, Body=body)

            obj_url = "https://{0}.s3-{1}.amazonaws.com/{2}".format(
                bucket_name, "us-west-2", key
            )

            return 1, "upload successful", obj_url
        except Exception as e:
            return -1, "unable upload to s3" + str(e), None

