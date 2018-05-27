provider "aws" {
  region  = "ap-southeast-2"
  version = "~> 1.14"
}

provider "cloudflare" {
  version = "~> 0.1"
}

terraform {
  backend "s3" {
    bucket         = "timfrastructure"
    dynamodb_table = "timfrastructure"
    key            = "servers/aws.tm.id.au" # TODO: Move state file to just 'servers'.
    encrypt        = true
  }
}
