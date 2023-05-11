data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.lambda.source_file
  output_path = var.lambda.output_file
}


resource "aws_lambda_function" "lambda" {
  for_each = { for each in var.lambda_handlers : each.name => each }

  filename      = var.lambda.output_file
  function_name = each.value.name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = each.value.handler

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = each.value.runtime
}
