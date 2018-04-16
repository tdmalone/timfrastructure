/**
 * Provider and remote backend configuration for SSL resources management.
 *
 * @author Tim Malone <tdmalone@gmail.com>
 */

provider "aws" {
  region  = "us-east-1" # Must be us-east-1 for Cloudfront & API Gateway support.
  version = "~> 1.14"
}

terraform {
  backend "s3" {
    bucket         = "timfrastructure"
    dynamodb_table = "timfrastructure"
    key            = "ssl"
    encrypt        = true
  }
}

# TODO: Add LetsEncrypt.

