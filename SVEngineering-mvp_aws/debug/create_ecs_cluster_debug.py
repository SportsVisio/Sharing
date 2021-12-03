import os
from aws_lambda.src.create_cluster.create_ecs_cluster import lambda_handler


if __name__=="__main__":
    event = {
        "queryStringParameters": {
            "user_id": "124567abc"
        }
    }
    lambda_handler(event,None)