variable "dynamodb" {
  description = "DynamoDb instance attributes."

  type = object({
    name      = string
    hash_key  = string 
    policy    = string
  })

  default = {
    "name": "assets"
    "hash_key": "hostname" 
    "policy": "DynamoDbAllowScanAndGetItem"
  }
}


variable "apigw" {
  description = "Api Gateway instance attributes."

  type = object({
    name        = string
    description = string
    stage       = string
  })

  default = {
    "name": "api-assets",
    "description": "This is a serverless API for demonstration purposes."
    "stage": "dev"
  }
}


variable "apigw_methods" {
  description = "ApiGateway methods attributes."

  type = list(object({
    name = string
    path = string
  }))

  default = [
    {
      "name" : "asset-scan",
      "path" : "assets"
    },
    {
      "name" : "asset-get-item",
      "path" : "asset"
    }
  ]
}


variable "lambda" {
  description = "Global lambda attributes."

  type = object({
    source_file = string
    output_file = string
    role        = string
  })

  default = {
    "source_file": "../lambda/parser.py",
    "output_file": "../lambda/lambda_function_payload.zip"
    "role": "api-lambda-role"
  }
}


variable "lambda_handlers" {
  description = "Lambdas handlers attributes."

  type = list(object({
    name    = string
    runtime = string
    handler = string
  }))

  default = [
    {
      "name" : "asset-scan",
      "runtime" : "python3.10",
      "handler" : "parser.scan"
    },
    {
      "name" : "asset-get-item",
      "runtime" : "python3.10",
      "handler" : "parser.get_item"
    }
  ]
}
