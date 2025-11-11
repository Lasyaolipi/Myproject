terraform {
  required_version = ">= 1.3"

  backend "s3" {
    bucket         = "terraform-backend-391313099163"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}
