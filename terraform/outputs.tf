output "api_url" {
  value = aws_api_gateway_deployment.api.invoke_url
}

output "stage" {
  value = var.apigw.stage
}

output "uri_scan" {
  value = var.apigw_methods[0].path
}

output "uri_put_item" {
  value = var.apigw_methods[1].path
}
