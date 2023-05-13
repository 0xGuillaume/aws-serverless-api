output "api_url" {
  value       = aws_api_gateway_deployment.api.invoke_url
  description = "The ApiGateway url."
}


output "stage" {
  value       = var.apigw.stage
  description = "The ApiGateway stage name."
}


output "uri_scan" {
  value       = var.apigw_methods[0].path
  description = "URI of the scan methods."
}


output "uri_get_item" {
  value       = var.apigw_methods[1].path
  description = "URI of the get_item methods."
}
