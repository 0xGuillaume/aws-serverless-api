terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {}


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


resource "aws_iam_role" "iam_for_lambda" {
  name               = "assets-apirole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  
  inline_policy {
    name = "DynamoDbScan"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["dynamodb:Scan"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}


data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../scripts/lambda_function.py"
  output_path = "../scripts/lambda_function_payload.zip"
}


resource "aws_lambda_function" "lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "../scripts/lambda_function_payload.zip"
  function_name = "ApiScanTf"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"

  environment {
    variables = {
      foo = "bar"
    }
  }
}
