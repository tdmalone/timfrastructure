/**
 * Provides general configuration for using Terraform, including resources used to manage the
 * Terraform configuration (such as backends).
 *
 * The git repo that holds this config is not controlled here, because the Terraform GitHub provider
 * doesn't manage personal repos (https://www.terraform.io/docs/providers/github/r/repository.html).
 *
 * @author Tim Malone <tdmalone@gmail.com>
 */

/**
 * AWS provider configuration, with version constraints.
 * Credentials are taken from the usual AWS environment variables.
 *
 * @see https://www.terraform.io/docs/providers/aws/index.html
 * @see https://www.terraform.io/docs/configuration/providers.html#provider-versions
 */
provider "aws" {
  region  = "ap-southeast-2"
  version = "~> 1.14"
}

/**
 * Cloudflare provider.
 * Credentials are taken from CLOUDFLARE_EMAIL and CLOUDFLARE_TOKEN env vars.
 *
 * @see https://www.terraform.io/docs/providers/cloudflare/index.html
 */
provider "cloudflare" {
  version = "~> 0.1"
}

/**
 * Datadog provider.
 * Credentials are taken from DATADOG_API_KEY and DATADOG_APP_KEY env vars.
 *
 * @see https://www.terraform.io/docs/providers/datadog/index.html
 */
provider "datadog" {
  version = "~> 0.1"
}

/**
 * S3 + DynamoDB backend for managing and locking Terraform remote state.
 *
 * Because these resources are managed by Terraform, they need to be created before the remote
 * backend is utilised. Therefore, when running `terraform plan` for the first time, you'll want
 * to comment out the `terraform` object below and allow the default, local backend to be used at
 * first.
 *
 * @see https://www.terraform.io/docs/backends/types/s3.html
 * @see https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
 * @see https://www.terraform.io/docs/providers/aws/r/dynamodb_table.html
 */
terraform {
  backend "s3" {
    bucket         = "timfrastructure"
    key            = "timfrastructure-tfstate"
    encrypt        = true
    dynamodb_table = "timfrastructure"
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
