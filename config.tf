/**
 * Provides general configuration for using Terraform, including resources used to manage the
 * Terraform configuration (such as Git respository and backends).
 *
 * @author Tim Malone <tdmalone@gmail.com>
 */

/**
 * Default AWS provider configuration, with version constraints.
 *
 * @see https://www.terraform.io/docs/providers/aws/index.html
 * @see https://www.terraform.io/docs/configuration/providers.html#provider-versions
 */
provider "aws" {
  region     = "ap-southeast-2"
  version    = "~> 1.12"
}

/**
 * CodeCommit repository for holding all Terraform configuration.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/code_commit_repository.html
 */
resource "aws_codecommit_repository" "git-timfrastructure" {
  repository_name = "timfrastructure"
  description     = "Holds IaC data (mostly Terraform) for Tim's cloud infrastructure"
}

/**
 * S3 + DynamoDB backend for managing and locking Terraform remote state.
 *
 * @see https://www.terraform.io/docs/backends/types/s3.html
 * @see https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
 * @see https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html
 */
terraform {
  backend "s3" {
    bucket         = "${aws_s3_bucket.s3-timfrastructure.bucket}"
    key            = "timfrastructure-tfstate"
    encrypt        = true
    dynamodb_table = "${aws_dynamodb_table.dynamodb-timfrastructure.name}"
  }
}
resource "aws_s3_bucket" "s3-timfrastructure" {
  bucket = "timfrastructure"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
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
    type = "N"
  }
}
