<p align='center'>
  <img src="https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white"/>
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white"/>
  <img src="https://img.shields.io/badge/Amazon%20DynamoDB-4053D6?style=for-the-badge&logo=Amazon%20DynamoDB&logoColor=white"/>
  <img src="https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue"/>
</p>

# Aws Api Serverless

## Description

## Api Gateway

There is two URIs available.

- `api-url/assets` : Returns all the DynamoDB items.

- `api-url/{hostname}` : Returns the item attributes specified in the url path.


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

If you would like to use a new set of DynamoDB items, you can run `./terraform/data/random_items.py`. 

You required to use `--amount` argument to set the amount of items you want to generate.

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
