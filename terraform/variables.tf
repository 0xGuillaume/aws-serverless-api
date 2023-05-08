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

variable "lambda_function" {
  type    = string
  default = "api-assets-scan"
}
