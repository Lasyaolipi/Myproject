module "vpc" {
  source          = "../../modules/vpc"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.2.0/24", "10.0.4.0/24"]
  region          = "ap-south-1"
}

module "s3_backend" {
  source       = "../../modules/s3-backend"
  state_bucket = "terraform-backend-391313099163"
  log_bucket   = "org-log-bucket-391313099163"
  region       = "ap-south-1"
}

module "cloudtrail" {
  source         = "../../modules/cloudtrail"
  s3_bucket_name = "org-log-bucket-391313099163"
}

module "ecr" {
  source       = "../../modules/ecr"
  repositories = ["mywebapp"]
}

module "guardduty" {
  source = "../../modules/guardduty"
}

module "security_hub" {
  source = "../../modules/security-hub"
}

module "iam" {
  source     = "../../modules/iam"
  github_org = "your-github-org"
  repo       = "your-repo"
  role_name  = "github-actions-role"
}

module "eks" {
  source             = "../../modules/eks"
  cluster_name       = var.cluster_name
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
  public_subnet_ids  = module.vpc.public_subnets
  region             = "ap-south-1"
}
