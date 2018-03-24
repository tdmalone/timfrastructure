
provider "aws" {
  region     = "ap-southeast-2"
  version    = "~> 1.12"
}

resource "aws_codecommit_repository" "timfrastructure" {
  repository_name = "timfrastructure"
  description     = "Holds IaC data for Tim's cloud infrastructure"
}
