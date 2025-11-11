terraform {
  required_version = ">= 1.3"

  backend "s3" {
    bucket         = "my-org-terraform-state-unique-12345"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-org-tf-locks-unique-12345"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}
