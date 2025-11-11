module "s3_backend" {
  source = "../../modules/s3-backend"
  state_bucket = var.state_bucket
  log_bucket = var.log_bucket
  region = var.region
}

resource "aws_dynamodb_table" "locks" {
  name         = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

output "state_bucket" { value = module.s3_backend.state_bucket }
output "log_bucket" { value = module.s3_backend.log_bucket }
