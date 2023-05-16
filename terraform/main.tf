terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {}


locals {
  json_items = file(var.items)
  items      = jsondecode(local.json_items)
}
