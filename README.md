# Terraform Infrastructure Boilerplate (Single AWS Account)

This repo contains a complete Terraform implementation (modules + envs) for a single-account AWS architecture:
- VPC, CloudTrail, S3 backend bootstrap
- ECR repositories
- EKS cluster (using terraform-aws-modules/eks/aws)
- IAM role for GitHub Actions OIDC
- GuardDuty and Security Hub modules
- Example envs: `bootstrap` and `prod`

**Important**: Update unique names (buckets, account IDs) in `envs/*/terraform.tfvars` before applying.

Folders:
- modules/
- envs/bootstrap
- envs/prod

Run bootstrap first: `cd infra/envs/bootstrap && terraform init && terraform apply`
Then configure backend and run prod: `cd infra/envs/prod && terraform init && terraform plan && terraform apply`
