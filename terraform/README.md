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


## Api Gateway

The _DummyAssets_ API Gateway is set with a quota of **200 requests a day**.

You can increase/decrease this quota or even change the period of time in `variables.tf` file inside the `apigw_plan` variable : 
- `quota_period` : Could be set with 3 values : `DAY`, `WEEK` or `MONTH`.
- `quota_limit` : Maximum number of requests that could be done.

```terraform
variable "apigw_plan" {
  default = {
    "name" : "DummyAssetsApiKey",
    "description" : "API Key authentication to requests Assets API.",
    "quota_limit" : 200,
    "quota_offset" : 0,
    "quota_period" : "DAY"
  }
}
```


