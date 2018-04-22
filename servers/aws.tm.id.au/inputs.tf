/**
 * Make the remote state for ../security available for querying.
 *
 * @see https://www.terraform.io/docs/providers/terraform/d/remote_state.html
 */
data "terraform_remote_state" "security" {
  backend = "s3"

  config {
    bucket = "timfrastructure"
    key    = "security"
  }
}

/**
 * Make the current AWS account accessible as a data attribute.
 *
 * @see https://www.terraform.io/docs/providers/aws/d/caller_identity.html
 * @see https://www.terraform.io/docs/configuration/data-sources.html
 */
data "aws_caller_identity" "current" {}

/**
 * Get the most recent AMI created via Packer.
 *
 * @see ./packer.json
 * @see https://www.terraform.io/docs/providers/aws/d/ami.html
 * @see http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html
 */
data "aws_ami" "packer_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["packer aws-tm-id-au *"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["${data.aws_caller_identity.current.account_id}"]
}
