<p align='center'>
  <img src="https://img.shields.io/badge/Amazon_AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white"/>
  <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white"/>
  <img src="https://img.shields.io/badge/Amazon%20DynamoDB-4053D6?style=for-the-badge&logo=Amazon%20DynamoDB&logoColor=white"/>
  <img src="https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue"/>
</p>

# Aws Api Serverless

## Description

## Api Gateway

## DynamoDB

### Items format

### Generate new items

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
