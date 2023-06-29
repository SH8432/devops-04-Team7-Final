terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.67.0"
    }
  }
  required_version = ">= 1.2.0"
  
  backend "s3" {
    bucket         = "project-terraform-up-and-running-state"
    key            = "terraform.tfstate"
    region         = "ap-northeast-2"
    encrypt        = true
    dynamodb_table = "project-terraform-up-and-running-lock"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}
