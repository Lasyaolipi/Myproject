terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.26"

  vpc_id = var.vpc_id
  subnets = concat(var.private_subnet_ids, var.public_subnet_ids)

  node_groups = {
    default = {
      desired_capacity = 2
      min_capacity     = 1
      max_capacity     = 3
      instance_types   = ["t3.medium"]
    }
  }
}

output "cluster_endpoint" { value = module.eks.cluster_endpoint }
output "cluster_name" { value = module.eks.cluster_id }
