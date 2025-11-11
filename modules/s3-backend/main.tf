resource "aws_s3_bucket" "state" {
  bucket = "terraform-backend-391313099163"
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
  bucket = "org-log-bucket-391313099163"
  acl    = "private"
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
