terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.20.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.27.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.0"
    }
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.3.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-backend-391313099163"
    key            = "prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

# 🔹 VPC Module
module "vpc" {
  source = "../../modules/vpc"
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
  region           = var.region
}

# 🔹 IAM Module
module "iam" {
  source   = "../../modules/iam"
  github_org = var.github_org
  repo       = var.repo
  role_name  = var.role_name
}

# 🔹 EKS Module
module "eks" {
  source  = "../../modules/eks"
  cluster_name        = var.cluster_name
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnets
  public_subnet_ids   = module.vpc.public_subnets
  region              = var.region
}

# 🔹 S3 Backend Module
module "s3_backend" {
  source = "../../modules/s3-backend"
  region = var.region
}

# 🔹 Security Hub
module "security_hub" {
  source = "../../modules/security-hub"
  region = var.region
}

# 🔹 CloudTrail
module "cloudtrail" {
  source = "../../modules/cloudtrail"
  region = var.region
}

# 🔹 GuardDuty
module "guardduty" {
  source = "../../modules/guardduty"
  region = var.region
}
