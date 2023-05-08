terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {}

locals {
  json_items = file("./items.json")
  items = jsondecode(local.json_items)
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


