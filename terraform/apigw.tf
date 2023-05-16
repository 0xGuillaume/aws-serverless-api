resource "aws_api_gateway_rest_api" "api" {
  name        = var.apigw.name
  description = var.apigw.description

  endpoint_configuration {
    types = [var.apigw.endpoint]
  }
}


resource "aws_api_gateway_resource" "api" {
  for_each = { for each in var.apigw_methods : each.name => each }

  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = each.value.path
}


resource "aws_api_gateway_api_key" "api" {
  name        = var.apigw_apikey.name
  description = var.apigw_apikey.name
}


resource "aws_api_gateway_usage_plan" "api" {
  name         = var.apigw_plan.name
  description  = var.apigw_plan.description
  product_code = "MYCODE"

  api_stages {
    api_id = aws_api_gateway_rest_api.api.id
    stage  = aws_api_gateway_stage.api.stage_name
  }

  quota_settings {
    limit  = var.apigw_plan.quota_limit
    offset = var.apigw_plan.quota_offset
    period = var.apigw_plan.quota_period
  }

  throttle_settings {
    burst_limit = 5
    rate_limit  = 10
  }
}


resource "aws_api_gateway_usage_plan_key" "api" {
  key_id        = aws_api_gateway_api_key.api.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.api.id
}


resource "aws_api_gateway_method" "api" {
  for_each = { for each in var.apigw_methods : each.name => each }

  rest_api_id      = aws_api_gateway_rest_api.api.id
  resource_id      = aws_api_gateway_resource.api[each.key].id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = each.value.key_required
}


resource "aws_api_gateway_integration" "api" {
  for_each = { for each in var.apigw_methods : each.name => each }

  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.api[each.key].id
  http_method             = aws_api_gateway_method.api[each.key].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda[each.key].invoke_arn
}


resource "aws_lambda_permission" "api" {
  for_each = { for each in var.lambda_handlers : each.name => each }

  statement_id  = "AllowMyDemoAPIInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda[each.value.name].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}


resource "aws_api_gateway_deployment" "api" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    redeployment = sha1(
      jsonencode([
        aws_api_gateway_resource.api,
        aws_api_gateway_method.api,
        aws_api_gateway_integration.api
      ])
    )
  }
}


resource "aws_api_gateway_stage" "api" {
  deployment_id = aws_api_gateway_deployment.api.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.apigw.stage
}
