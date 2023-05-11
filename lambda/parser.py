"""Functions to handle DynamoDB table."""
import json
from boto3 import client


client = client('dynamodb')


def scan(context:dict, event) -> dict:
    """Get all items of DynamoDB asset table."""

    data = client.scan(
        TableName="assets"
    )

    response = {
      'statusCode': 200,
      'body': json.dumps(data["Items"]),
      'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
    }

    return response


def get_item(context:dict, event) -> dict:
    """Get a single item of DynamoDb asset table."""

    item = client.get_item(
        TableName="assets",
        Key={
            "hostname": {"S": "AWSUX01"}
        }
    )

    response = {
      'statusCode': 200,
      'body': json.dumps(item["Item"]),
      'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
    }

    return response
