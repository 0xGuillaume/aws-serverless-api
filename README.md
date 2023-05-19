<p align='center'>
  <img src="https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white"/>
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white"/>
  <img src="https://img.shields.io/badge/Amazon%20DynamoDB-4053D6?style=for-the-badge&logo=Amazon%20DynamoDB&logoColor=white"/>
  <img src="https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue"/>
</p>

# Aws Api Serverless

> This project has been built for development and test purpose.

_DummyAssets_ is a serverless API powered by AWS. It is based on 3 services : 

- [Api Gateway](https://aws.amazon.com/fr/api-gateway/) : Provides RESTful API with 2 GET methods.

- [Lambda](https://aws.amazon.com/fr/lambda/) : Python functions to query DynamoDB items based on Api Gateway requests.

- [DynamoDB](https://aws.amazon.com/fr/dynamodb/) : NoSQL database filled with dummy items (EC2 instances attributes).


## Api Gateway

_DummyAssets_ API Gateway provides a REST API with 2 GET methods :

- `api-url/stage/assets` : Returns all the DynamoDB items table.

- `api-url/stage/{hostname}` : Returns the item specified in the path.

Both of these methods **required an API Key**. The **API Key** is given by the terraform outputs. Because `api_key` output is **sensitive** you should run the bellow command :

```bash
$ terraform outputs --json # `| jq` for a better render.
```

## DynamoDB

_DummyAssetsDDB_ is a DynamoDB (_NoSQL_) table filled with a random set of instances with random attributes values. 

Each table items use the bellow data format.

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

> **NOTE :** You are **required** to use `--amount` argument which set the amount of items you want to generate.

```bash
$ python3 random_items.py --amount 500
```

## Demo

### Terraform

To build up _DummyAssets_, you first need to install [Terraform](https://www.terraform.io/). 

Then there are several ways to authenticate and configure the AWS provider.

This project has been built using the [Environment Variables](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables) method. But you first need to [create](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_access-keys.html#Using_CreateAccessKey) an **Access Key** with the appropriate permissions.

```bash
$ export AWS_ACCESS_KEY_ID="anaccesskey"
$ export AWS_SECRET_ACCESS_KEY="asecretkey"
$ export AWS_REGION="eu-west-1" # Or any other region you want to use.
```

---

One you correctly configure the AWS provider run following commands.

```bash
$ cd terraform/
$ terraform init
$ terraform apply --auto-approve
```

### Auto requests

You can run `demo.py` file in order to send automated requests. The script randomly requests one of the two available URIs (`/assets` or `/{hostname}`).

> **NOTE :** You are **required** to set the amount of requests you want to send while running the script.

```bash
$ python3 demo.py --amount 50
```

Also there is by default a **one second interval** between each request but you can set your own interval.

```bash
$ python3 demo.py --amount 50 --interval 0
```
