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
    key            = "ide"
    encrypt        = true
  }
}
