terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
    bucket = "bucket-name"
    key = "key-name"
    region = "ap-northeast-2"
  }
}

provider "aws" {
  profile = var.profile
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
}

module "subnets" {
  source = "./subnets"
  
  vpc_id = aws_vpc.main.id
  subnet_cidr_blocks = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24"
  ]
  subnet_azs = [
    "ap-northeast-2a",
    "ap-northeast-2b",
    "ap-northeast-2c"
  ]
}
