# DummyAssets Terraform

Terraform files are based on deployed services to gain more readability and easier management. 

```bash
.
├── data                        # Data files
│   ├── items.json              # DynamoDB random dataset
│   └── random_items.py         # Generate random DynamoDB items
├── lambda                      # Lambda code
│   └── parser.py               # Lambda python functions
├── apigw.tf                    # ApiGateway terraform blocks
├── dynamodb.tf                 # DynamoDB terraform blocks
├── lambda.tf                   # Lambda terraform blocks
├── main.tf                     # Terraform version & provider
├── outputs.tf                  # Outputs values
├── README.md                   # Readme
└── variables.tf                # Terraform variables
```

## Dynamo DB and Lambdas

Both `scan` and `get_item` lambdas are querying `DummyAssets` _DyamoDB_ table. So if you would like to change the table name for your own need, you have to update the value in **two** different file.

- `variables.tf` : Check the `name` key in `dynamodb` variable block.
```terraform
variable "dynamodb" {
  description = "DynamoDb instance attributes."

  type = object({
    name     = string
    hash_key = string
    policy   = string
  })

  default = {
    "name" : "YourTableName"
    "hash_key" : "hostname"
    "policy" : "DynamoDbAllowScanAndGetItem"
  }
}
```

- `lambda/parser.py`: `TABLE` constant.
```python
TABLE = "YourTableName"
```
