# Terraform Infrastructure (Single AWS Account)
Account: 391313099163
Region: ap-south-1

This repo contains a modular Terraform infrastructure setup for a single-account AWS architecture.
Run bootstrap first to create backend resources, then deploy the prod environment.

## Quick start
1. Bootstrap backend (creates S3 bucket + DynamoDB table):
   ```bash
   cd envs/bootstrap
   terraform init
   terraform apply
   ```

2. Deploy production stack:
   ```bash
   cd ../prod
   terraform init
   terraform plan -out plan.tfplan
   terraform apply plan.tfplan
   ```

## Notes
- Update secrets and GitHub workflow repository/secret names as needed.
- The GitHub Actions workflows are configured to use an OIDC-assumable IAM role that Terraform will create (output `module.iam.role_arn`).
