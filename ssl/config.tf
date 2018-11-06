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
  required_version = "~> 0.11.7"

  backend "s3" {
    region         = "ap-southeast-2"
    bucket         = "timfrastructure"
    dynamodb_table = "timfrastructure"
    key            = "ssl"
    encrypt        = true
  }
}

# TODO: Add LetsEncrypt.

