data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../lambda/lambda_function.py"
  output_path = "../lambda/lambda_function_payload.zip"
}


resource "aws_lambda_function" "lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "../lambda/lambda_function_payload.zip"
  function_name = var.lambda_function
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.10"
}
