resource "aws_s3_bucket" "state" {
  bucket = var.state_bucket
  acl    = "private"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning { enabled = true }
  lifecycle_rule {
    id = "tfstate"
    enabled = true
    noncurrent_version_expiration { days = 30 }
  }
  tags = { Name = "terraform-state-bucket" }
}

resource "aws_s3_bucket" "logs" {
  bucket = var.log_bucket
  acl    = "private"
  force_destroy = false
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  versioning { enabled = true }
  tags = { Name = "org-log-bucket" }
}
