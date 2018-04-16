provider "aws" {
  region  = "ap-southeast-2"
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
