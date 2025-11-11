Instructions:
1. Bootstrap backend:
   cd envs/bootstrap
   terraform init
   terraform apply

2. Configure backend (envs/prod/provider.tf) uses the bucket created by bootstrap.
3. Deploy prod:
   cd envs/prod
   terraform init
   terraform plan
   terraform apply

Update terraform.tfvars in each env with real unique names and account id before apply.
