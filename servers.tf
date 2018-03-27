/**
 * Defines EC2 instances used for various purposes, and their related resources.
 *
 * @author Tim Malone <tdmalone@gmail.com>
 */

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

/**
 * Main server for playing around with stuff, hosting a development environment, etc.
 *
 * TODO: Transition this to Bionic (18.04) when it's released.
 * TODO: Link up additional details incl VPC, elastic IP etc.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/instance.html
 */
resource "aws_instance" "aws-tm-id-au" {
  #ami = "${data.aws_ami.ubuntu-latest.id}"
  ami                     = "ami-4cc8232e"             # 14.04 2017-11-15
  instance_type           = "t2.micro"
  disable_api_termination = true
  iam_instance_profile    = "EC2-SimpleSystemsManager"

  tags {
    Name    = "aws.tm.id.au (14.04)"
    Purpose = "Testing and Learning"
  }
}
