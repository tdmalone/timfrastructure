/**
 * Current/old server for playing around with stuff, hosting a development environment, etc.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/instance.html
 */
resource "aws_instance" "aws-tm-id-au" {
  ami                     = "ami-4cc8232e"             # 14.04 2017-11-15
  instance_type           = "${var.server_type}"
  disable_api_termination = true
  iam_instance_profile    = "ubuntu"

  monitoring              = false                      # Just for now, to keep costs down.

  availability_zone           = "ap-southeast-2a"
  subnet_id                   = "${data.terraform_remote_state.vpc.aws_subnet_public_a_id}"
  associate_public_ip_address = true

  private_ip = "10.0.0.186" # TODO: Change to .101 when this instance is safe for recreation.

  root_block_device {
    volume_type = "gp2"
    volume_size = "15"

    # TODO: Remove this to set back to the default of true, when it's safe to destroy this instance.
    delete_on_termination = false
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

  lifecycle {
    prevent_destroy = true

    # Prevent Terraform from trying to recreate the instance when it is stopped.
    ignore_changes = ["associate_public_ip_address"]
  }
}

/**
 * Upcoming main dev server, based on a custom API built with Packer and Ansible.
 *
 * @see ./packer-ubuntu.json
 * @see ./ubuntu.yml
 * @see https://www.terraform.io/docs/providers/aws/r/instance.html
 */
resource "aws_instance" "ubuntu_tm_id_au" {
  ami                     = "${data.aws_ami.packer_ubuntu_latest.id}"
  instance_type           = "${var.server_type}"
  disable_api_termination = false
  iam_instance_profile    = "ubuntu"

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
    "Name"       = "ubuntu.tm.id.au"
    "Managed By" = "Terraform"
    "OS"         = "Ubuntu 16.04"    # TODO: Get this from the Packer build or AMI somehow?
  }

  volume_tags {
    "Name"       = "ubuntu.tm.id.au"
    "Managed By" = "Terraform"
  }

  # Prevent Terraform from trying to recreate the instance when it is stopped.
  lifecycle {
    ignore_changes = ["associate_public_ip_address"]
  }
}

/**
 * Upcoming CentOS application test server, based on a custom API built with Packer and Ansible.
 *
 * @see ./packer-centos.json
 * @see ./centos.yml
 * @see https://www.terraform.io/docs/providers/aws/r/instance.html
 */
resource "aws_instance" "centos_tm_id_au" {
  ami                     = "${data.aws_ami.packer_centos_latest.id}"
  instance_type           = "${var.server_type}"
  disable_api_termination = false
  iam_instance_profile    = "centos"

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
    "OS"         = "CentOS 7.4 1801" # TODO: Get this from the Packer build or AMI somehow?
  }

  volume_tags {
    "Name"       = "centos.tm.id.au"
    "Managed By" = "Terraform"
  }

  # Prevent Terraform from trying to recreate the instance when it is stopped.
  lifecycle {
    ignore_changes = ["associate_public_ip_address"]
  }
}
