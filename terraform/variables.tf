variable "ddb_hashkey" {
  type    = string
  default = "hostname"
}

variable "ddb_policy" {
  type    = string
  default = "DynamoDBScanAllow"
}

variable "ddb_table" {
  type    = string
  default = "assets"
}

variable "lambda_role" {
  type    = string
  default = "api-lambda-role"
}

variable "apigw_name" {
  type    = string
  default = "api-assets-serverless"
}

variable "apigw_pathpart" {
  type    = string
  default = "assets"
}

variable "apigw_stage" {
  type    = string
  default = "dev"
}

variable "apigw" {
  type = list(object({
    name = string
    path = string
  }))
  default = [
    {
      "name": "asset-scan",
      "path": "assets"
    },
    {
      "name": "asset-get-item",
      "path": "asset"
    }
  ]
}

variable "lambda" {
  type = list(object({
    name = string
    runtime = string
    handler = string
  }))
  default = [
    {
      "name": "asset-scan",
      "runtime": "python3.10",
      "handler": "lambda_function.scan"
    },
    {
      "name": "asset-get-item",
      "runtime": "python3.10",
      "handler": "lambda_function.get_item"
    }
  ]
}
