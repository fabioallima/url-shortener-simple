import json
import uuid
import boto3
import os

dynamodb = boto3.client('dynamodb')
TABLE_NAME = os.environ['TABLE_NAME']

def lambda_handler(event, context):
    try:
        body = json.loads(event['body'])
        original_url = body['originalUrl']
        expiration_time = int(body['expirationTime'])
    except (KeyError, ValueError, json.JSONDecodeError) as e:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": str(e)})
        }

    short_code = str(uuid.uuid4())[:8]

    try:
        dynamodb.put_item(
            TableName=TABLE_NAME,
            Item={
                'id': {'S': short_code},
                'originalUrl': {'S': original_url},
                'expirationTime': {'N': str(expiration_time)}
            }
        )
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": f"Failed to save: {str(e)}"})
        }

    return {
        "statusCode": 200,
        "body": json.dumps({"code": short_code})
    }
