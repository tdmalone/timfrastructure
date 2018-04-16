# Admin S3 bucket.
# Billing?
# TF state config.

resource "aws_s3_bucket" "s3-timfrastructure" {
  bucket = "timfrastructure"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_dynamodb_table" "dynamodb-timfrastructure" {
  name           = "timfrastructure"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }
}
