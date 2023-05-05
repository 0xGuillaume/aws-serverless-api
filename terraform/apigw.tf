resource "aws_apigatewayv2_api" "example" {
  name                       = "example-websocket-api"
  protocol_type              = "HTTP"
  #route_selection_expression = "${request.method}"
}

resource "aws_apigatewayv2_route" "example" {
  api_id    = aws_apigatewayv2_api.example.id
  route_key = "ANY /assets/"
}
