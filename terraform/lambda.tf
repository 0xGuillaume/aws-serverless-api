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
  name               = var.lambda.role
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  inline_policy {
    name = var.dynamodb.policy

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "dynamodb:Scan",
            "dynamodb:GetItem"
          ]
          Effect   = "Allow"
          Resource = aws_dynamodb_table.dynamodb.arn
        },
      ]
    })
  }
}


data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.lambda.source_file
  output_path = var.lambda.output_file
}


resource "aws_lambda_function" "lambda" {
  for_each = { for each in var.lambda_handlers : each.name => each }

  description   = each.value.description
  filename      = var.lambda.output_file
  function_name = each.value.name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = each.value.handler

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = each.value.runtime
}
