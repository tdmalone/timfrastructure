data "terraform_remote_state" "security" {
  backend = "s3"

  config {
    bucket = "timfrastructure"
    key    = "security"
  }
}

/**
 * Get the most recent Ubuntu LTS AMI for later use.
 *
 * @see https://www.terraform.io/docs/providers/aws/d/ami.html
 * @see http://docs.aws.amazon.com/cli/latest/reference/ec2/describe-images.html
 */
data "aws_ami" "ubuntu-latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
