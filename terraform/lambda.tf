data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../lambda/lambda_function.py"
  output_path = "../lambda/lambda_function_payload.zip"
}


resource "aws_lambda_function" "lambda" {
  for_each = { for each in var.lambda : each.name => each }

  filename      = "../lambda/lambda_function_payload.zip"
  function_name = each.value.name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = each.value.handler

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = each.value.runtime
}
