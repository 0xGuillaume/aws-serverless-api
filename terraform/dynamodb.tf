resource "aws_dynamodb_table" "dynamodb" {

  name           = var.ddb_table
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = var.ddb_hash_key

  attribute {
    name = var.ddb_hash_key
    type = "S"
  }
}


resource "aws_dynamodb_table_item" "dynamodb" {
  table_name = aws_dynamodb_table.dynamodb.name
  hash_key   = aws_dynamodb_table.dynamodb.hash_key

  item = <<ITEM
{
  "hostname": {"S": "AWSUX01"},
  "os": {"S": "linux"},
  "region": {"S": "eu-west-1"}
}
ITEM
}
