terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}


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
  name               = "foo-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}


data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function_payload.zip"
}


resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.test"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

#resource "aws_lambda_function" "api" {
#  function_name = "monapi"
#  role          = "arn:aws:iam::331664693494:role/service-role/foo-role-p0plyx53"
#  filename      = "lambda.py"
#  #handler       = "index.test"
#  #source_code_hash = data.archive_file.lambda.output_base64sha256
#
#  runtime = "nodejs16.x"
#
#  environment {
#    variables = {
#      foo = "bar"
#    }
#  }
#}
