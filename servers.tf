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
  instance_type           = "${var.server_type}"
  disable_api_termination = true
  iam_instance_profile    = "EC2-SimpleSystemsManager"
  monitoring              = true

  vpc_security_group_ids = [
    "${aws_security_group.default.id}",
    "${aws_security_group.outbound.id}",
    "${aws_security_group.https.id}",
    "${aws_security_group.ssh.id}",
    "${aws_security_group.ping.id}",
  ]
}

# https://www.terraform.io/docs/providers/aws/r/eip.html
resource "aws_eip" "aws-tm-id-au" {
  instance = "${aws_instance.aws-tm-id-au.id}"
  vpc      = true
}

/**
 *
 *
 * @see https://www.terraform.io/docs/providers/aws/r/key_pair.html
 */
resource "aws_key_pair" "default" {
  key_name   = "Tim's AWS key"
  public_key = ""

  #public_key ="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9RmTU2ArhbzKM14mtxQpTosFkvveokv19Lu36Ze/BlKCapknYiD7tY765ZlaC761WxuIZv0jx2JapdmJXdypjAceQvB1pbRGnwbvUVnoq7IgnbEJ1popgh0BD/TWTd2umRoPF1dSkGC+nYyDO0qKi+M2cHw35M8oNEBDRPx4u1XbwW7yEKcO66WZ/h7jWUXSanWjDn3ngOYMlRarKBMyflRsoLsdDjTZC2HfSPIDfDLuwqrm6GtFW6AsFhr7U1RdgN2FmFGEY9LYg2k2jYBGRHgcOAuTrmFRh2dUow74mmpkj9w8Ou0nKfeuRIXRHQ0Fcb8UVmSP95fzYeTJfwir5 tdmalone@gmail.com"
}

/**
 *
 *
 * @see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
 */
/*
resource "aws_autoscaling_group" "default" {
  launch_configuration      = "${aws_launch_configuration.default.name}"
  max_size                  = 1
  min_size                  = 0
  metrics_granularity       = "1Minute"
  force_delete              = false
  wait_for_capacity_timeout = "10m"
}
*/


/**
 *
 *
 * @see https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
 */
/*
resource "aws_launch_configuration" "default" {
  image_id          = ""
  instance_type     = ""
  name              = "${var.server_hostname}"
  instance_type     = "${var.server_type}"
  key_name          = "${aws_key_pair.default.key_name}"
  name              = "${var.server_hostname}"
  enable_monitoring = false
  ebs_optimized     = false
}
*/
