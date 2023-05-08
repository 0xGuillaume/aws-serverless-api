import boto3
import json


client = boto3.client('dynamodb')


def lambda_handler(context, event):
    """."""

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
