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
