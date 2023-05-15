import boto3
import json


def get_item(context:dict, event) -> dict:
    """Get a single item of DynamoDb asset table."""

    return {
        'statusCode': 200,
        'body': json.dumps(event)
    }
