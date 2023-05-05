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

  #attribute {
  #  name = "os"
  #  type = "S"
  #}

  #attribute {
  #  name = "up_to_date"
  #  type = "S"
  #}
}
