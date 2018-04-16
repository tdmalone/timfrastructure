provider "aws" {
  region  = "ap-southeast-2"
  version = "~> 1.14"
}

terraform {
  backend "s3" {
    bucket         = "timfrastructure"
    dynamodb_table = "timfrastructure"
    key            = "servers/aws.tm.id.au"
    encrypt        = true
  }
}
