provider "aws" {
  region  = "ap-southeast-2"
  version = "~> 1.14"
}

terraform {
  required_version = "~> 0.11.7"

  backend "s3" {
    region         = "ap-southeast-2"
    bucket         = "timfrastructure"
    dynamodb_table = "timfrastructure"
    key            = "api"
    encrypt        = true
  }
}

/**
 * Make the current AWS account accessible as a data attribute.
 *
 * @see https://www.terraform.io/docs/providers/aws/d/caller_identity.html
 * @see https://www.terraform.io/docs/configuration/data-sources.html
 */
data "aws_caller_identity" "current" {}
