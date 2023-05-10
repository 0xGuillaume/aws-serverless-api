import boto3
import json


client = boto3.client('dynamodb')


def scan(context, event) -> dict:
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


def get_item(context, event) -> dict:
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
