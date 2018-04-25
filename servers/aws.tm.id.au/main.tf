# EC2
# CloudWatch alarms
# Datadog?
# snapshots
# key pair

/**
 * Defines EC2 instances used for various purposes, and their related resources.
 *
 * @author Tim Malone <tdmalone@gmail.com>
 */

/**
 * Main server for playing around with stuff, hosting a development environment, etc.
 *
 * TODO: Transition this to Bionic (18.04) when it's released.
 * TODO: Link up additional details incl VPC, elastic IP etc.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/instance.html
 */
resource "aws_instance" "aws-tm-id-au" {
  ami                     = "ami-4cc8232e"             # 14.04 2017-11-15
  instance_type           = "${var.server_type}"
  disable_api_termination = true
  iam_instance_profile    = "EC2-SimpleSystemsManager"
  monitoring              = false                      # Just for now, to keep costs down.

  availability_zone           = "ap-southeast-2a"
  subnet_id                   = "${data.terraform_remote_state.vpc.aws_subnet_public_a_id}"
  associate_public_ip_address = true

  private_ip = "10.0.0.186" # TODO: Change to .101 when this instance is safe for recreation.

  root_block_device {
    volume_type = "gp2"
    volume_size = "15"
  }

  vpc_security_group_ids = [
    "${data.terraform_remote_state.security.aws_security_group_default_id}",
    "${data.terraform_remote_state.security.aws_security_group_outbound_id}",
    "${data.terraform_remote_state.security.aws_security_group_https_id}",
    "${data.terraform_remote_state.security.aws_security_group_ssh_id}",
    "${data.terraform_remote_state.security.aws_security_group_ping_id}",
  ]

  tags {
    "Name"       = "aws.tm.id.au"
    "Managed By" = "Terraform"
    "OS"         = "Ubuntu 14.04"
  }

  volume_tags {
    "Name"       = "aws.tm.id.au"
    "Managed By" = "Terraform"
  }
}

/**
 *
 *
 * @see https://www.terraform.io/docs/providers/aws/r/ami_from_instance.html
 */
#resource "aws_ami_from_instance" "aws_tm_id_au" {
#  name               = "aws.tm.id.au"
#  source_instance_id = "${aws_instance.aws-tm-id-au.id}"
#}

/**
 * Upcoming dev server based on a custom API built with Packer and Ansible.
 *
 * @see ./packer-ubuntu.json
 * @see ./ubuntu.yml
 * @see https://www.terraform.io/docs/providers/aws/r/instance.html
 */
resource "aws_instance" "xenial_tm_id_au" {
  ami                     = "${data.aws_ami.packer_ubuntu_latest.id}"
  instance_type           = "${var.server_type}"
  disable_api_termination = false
  iam_instance_profile    = "EC2-SimpleSystemsManager"
  monitoring              = false                                     # Just for now, to keep costs down.

  availability_zone           = "ap-southeast-2a"
  subnet_id                   = "${data.terraform_remote_state.vpc.aws_subnet_public_a_id}"
  associate_public_ip_address = true

  private_ip = "10.0.0.102"

  root_block_device {
    volume_type = "gp2"
    volume_size = "8"
  }

  vpc_security_group_ids = [
    "${data.terraform_remote_state.security.aws_security_group_default_id}",
    "${data.terraform_remote_state.security.aws_security_group_outbound_id}",
    "${data.terraform_remote_state.security.aws_security_group_https_id}",
    "${data.terraform_remote_state.security.aws_security_group_ssh_id}",
    "${data.terraform_remote_state.security.aws_security_group_ping_id}",
  ]

  tags {
    "Name"       = "xenial.tm.id.au"
    "Managed By" = "Terraform"
    "OS"         = "Ubuntu 16.04"
  }

  volume_tags {
    "Name"       = "xenial.tm.id.au"
    "Managed By" = "Terraform"
  }
}

/**
 * CentOS test server based on a custom API built with Packer and Ansible.
 *
 * @see ./packer-centos.json
 * @see ./centos.yml
 * @see https://www.terraform.io/docs/providers/aws/r/instance.html
 */
resource "aws_instance" "centos_tm_id_au" {
  ami                     = "${data.aws_ami.packer_centos_latest.id}"
  instance_type           = "${var.server_type}"
  disable_api_termination = false
  iam_instance_profile    = "EC2-SimpleSystemsManager"
  monitoring              = false                                     # Just for now, to keep costs down.

  availability_zone           = "ap-southeast-2a"
  subnet_id                   = "${data.terraform_remote_state.vpc.aws_subnet_public_a_id}"
  associate_public_ip_address = true

  private_ip = "10.0.0.103"

  root_block_device {
    volume_type = "gp2"
    volume_size = "8"
  }

  vpc_security_group_ids = [
    "${data.terraform_remote_state.security.aws_security_group_default_id}",
    "${data.terraform_remote_state.security.aws_security_group_outbound_id}",
    "${data.terraform_remote_state.security.aws_security_group_https_id}",
    "${data.terraform_remote_state.security.aws_security_group_ssh_id}",
    "${data.terraform_remote_state.security.aws_security_group_ping_id}",
  ]

  tags {
    "Name"       = "centos.tm.id.au"
    "Managed By" = "Terraform"
    "OS"         = "CentOS 7.4 1801"
  }

  volume_tags {
    "Name"       = "centos.tm.id.au"
    "Managed By" = "Terraform"
  }
}

/**
 * Elastic IP address for main server.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/eip.html
 */
resource "aws_eip" "aws-tm-id-au" {
  instance = "${aws_instance.aws-tm-id-au.id}"
  vpc      = true

  tags {
    "Name"       = "aws.tm.id.au"
    "Managed By" = "Terraform"
  }
}

/**
 * Creates an Elastic File System resource for use between multiple EC2 instances.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/efs_file_system.html
 */
resource "aws_efs_file_system" "default" {
  encrypted = true

  tags {
    "Name"       = "Tim Repos"
    "Managed By" = "Terraform"
  }
}

/**
 * Creates a mount target for connecting the main EFS to instances.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/efs_mount_target.html
 */
resource "aws_efs_mount_target" "alpha" {
  file_system_id = "${aws_efs_file_system.default.id}"
  subnet_id      = "${data.terraform_remote_state.vpc.aws_subnet_public_a_id}"
  ip_address     = "10.0.0.87"                                                 # TODO: Change to .11 when ready to recreate.
}

/**
 * Default key pair for use with EC2 instances.
 *
 * TODO: Manage application of the public_key without breaking the existing key.
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


/**
 *
 *
 * @see https://www.terraform.io/docs/providers/aws/r/instance.html
 */
/*
resource "aws_instance" "ansible" {
  ami = "ami-c9c403ab" # Ansible Tower 3.2.3 on CentOS 7 as recommended at https://www.ansible.com/products/tower/trial
  instance_type = "t2.micro"
  subnet_id = "subnet-dc832995"
  tags {
    Name = "ansible.tm.id.au"
  }
}
*/

