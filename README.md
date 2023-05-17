<p align='center'>
  <img src="https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white"/>
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white"/>
  <img src="https://img.shields.io/badge/Amazon%20DynamoDB-4053D6?style=for-the-badge&logo=Amazon%20DynamoDB&logoColor=white"/>
  <img src="https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue"/>
</p>

# Aws Api Serverless

## Description

## Api Gateway

_Assets_ API Gateway provides a REST API with 2 GET methods :

- `api-url/assets` : Returns all the DynamoDB items.

- `api-url/{hostname}` : Returns the item attributes specified in the url path.

Both of these methods required an **API Key** to be requested. The **API Key** is given by the terraform outputs. Because `api_key` output is **sensitive** you should run the bellow command :

```bash
terraform outputs --json
```

## DynamoDB

### Items format

DynamoDB table uses the bellow data format.

```json
"Item1": {
	"hostname": { "S": "AWSDEB1" },
	"os": { "S": "debian" },
	"region": { "S": "us-west-2" },
	"ipaddress": { "S": "10.28.247.21" },
	"state": { "S": "terminated" },
	"monitoring": {	"S": "False" }
}
```

### Generate new items

To use a new set of DynamoDB items, you can run `./terraform/data/random_items.py`. 

You are **required** to use `--amount` argument which set the amount of items you want to generate.

```bash
python3 random_items.py --amount 500
```

## Demo

You can run `demo.py` file in order to send automated requests. The script randomly requests one of the two available URIs (`/assets` or `/{hostname}`).

You are **required** to set the amount of requests you want to send while running the script.

```bash
python3 demo.py --amount 50
```

Also there is by default a **one second interval** between each request but you can set your own interval.

```bash
python3 demo.py --amount 50 --interval 0
```
