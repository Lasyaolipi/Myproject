module "s3_backend" {
  source       = "../../modules/s3-backend"
  state_bucket = "terraform-backend-391313099163"
  log_bucket   = "org-log-bucket-391313099163"
  region       = "ap-south-1"
}

resource "aws_dynamodb_table" "locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

output "state_bucket" { value = module.s3_backend.state_bucket }
output "log_bucket" { value = module.s3_backend.log_bucket }
