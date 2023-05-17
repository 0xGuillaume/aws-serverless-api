# DummyAssets Terraform

```bash
.
├── data                        # Data files
│   ├── items.json              # DynamoDN random dataset
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
