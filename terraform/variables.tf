variable "items" {
  description = "JSON file containing items."

  type    = string
  default = "./data/items.json"
}


variable "dynamodb" {
  description = "DynamoDb instance attributes."

  type = object({
    name     = string
    hash_key = string
    policy   = string
  })

  default = {
    "name" : "assets"
    "hash_key" : "hostname"
    "policy" : "DynamoDbAllowScanAndGetItem"
  }
}


variable "apigw" {
  description = "Api Gateway instance attributes."

  type = object({
    name        = string
    description = string
    endpoint    = string
    stage       = string
  })

  default = {
    "name" : "api-assets",
    "description" : "This is a serverless API for demonstration purposes."
    "endpoint" : "REGIONAL"
    "stage" : "dev"
  }
}


variable "apigw_apikey" {
  description = "Api Gateway API key attributes."

  type = object({
    name        = string
    description = string
  })

  default = {
    "name" : "AssetsApiKey",
    "description" : "Assets Api Key required to requests the API."
  }
}


variable "apigw_plan" {
  description = "ApiGateway usage plan attributes for requests limitation."

  type = object({
    name         = string
    description  = string
    quota_limit  = number
    quota_offset = number
    quota_period = string
  })

  default = {
    "name" : "AssetsApiKey",
    "description" : "API Key authentication to requests Assets API.",
    "quota_limit" : 100,
    "quota_offset" : 0,
    "quota_period" : "DAY"
  }
}


variable "apigw_methods" {
  description = "ApiGateway methods attributes."

  type = list(object({
    name         = string
    path         = string
    key_required = bool
  }))

  default = [
    {
      "name" : "asset-scan",
      "path" : "assets",
      "key_required" : true
    },
    {
      "name" : "asset-get-item",
      "path" : "{hostname+}",
      "key_required" : true
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
    "source_file" : "./lambda/parser.py",
    "output_file" : "./lambda/lambda_function_payload.zip"
    "role" : "api-lambda-role"
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
