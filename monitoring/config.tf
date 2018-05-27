provider "aws" {
  region  = "ap-southeast-2"
  version = "~> 1.14"
}

provider "datadog" {
  version = "~> 0.1"
}

terraform {
  backend "s3" {
    bucket         = "timfrastructure"
    dynamodb_table = "timfrastructure"
    key            = "monitoring"
    encrypt        = true
  }
}
