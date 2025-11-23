terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.19.0"
    }
  }
  backend "s3" {
    bucket = "warsame-memos-bucket"
    key = "terraform.tfstate"
    region = "eu-west-2"
    dynamodb_table = "memos-locks"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-west-2"
}