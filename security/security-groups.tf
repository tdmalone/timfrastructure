/**
 * Defines EC2 security groups.
 *
 * @author Tim Malone <tdmalone@gmail.com>
 * @see https://www.terraform.io/docs/providers/aws/r/security_group.html
 */

resource "aws_security_group" "default_vpc_default" {
  name        = "default"
  description = "default VPC security group"
  vpc_id      = "vpc-a84dbacf" # TODO: Reference this.

  ingress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    self      = true
  }

  tags {
    "Name"       = "default VPC security group"
    "Managed By" = "Terraform"
  }
}

resource "aws_security_group" "default" {
  name        = "default"
  description = "default VPC security group"
  vpc_id      = "vpc-9ba455fc" # TODO: Reference this.

  ingress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    self      = true
  }

  tags {
    "Name"       = "default VPC security group"
    "Managed By" = "Terraform"
  }
}

resource "aws_security_group" "outbound" {
  name        = "Unrestricted outbound"
  description = "Unrestricted outbound"
  vpc_id      = "vpc-9ba455fc" # TODO: Reference this.

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "Name"       = "Unrestricted outbound"
    "Managed By" = "Terraform"
  }
}

resource "aws_security_group" "blank" {
  name        = "Blank Security Group (no access)"
  description = "Blank Security Group (no access)"
  vpc_id      = "vpc-9ba455fc" # TODO: Reference this.

  tags {
    "Name"       = "Blank Security Group (no access)"
    "Managed By" = "Terraform"
  }
}

resource "aws_security_group" "packer_builds" {
  name        = "Packer Builds"
  description = "Packer Builds"
  vpc_id      = "vpc-9ba455fc" # TODO: Reference this.

  ingress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    self      = true
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_address_list_1}"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_address_list_3}"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.terraform_remote_state.aws_tm_id_au.aws_tm_id_au_external_ip}/32"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    "Name"       = "Packer Builds"
    "Managed By" = "Terraform"
  }
}

resource "aws_security_group" "https" {
  name        = "Restricted inbound HTTP/HTTPS"
  description = "Restricted inbound HTTP/HTTPS"
  vpc_id      = "vpc-9ba455fc" # TODO: Reference this.

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_address_list_1}"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_address_list_1}"]
  }

  ingress {
    description = "Alternate HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_address_list_1}"]
  }

  tags {
    "Name"       = "Restricted inbound HTTP/HTTPS"
    "Managed By" = "Terraform"
  }
}

resource "aws_security_group" "ssh" {
  name        = "Restricted inbound SSH"
  description = "Restricted inbound SSH"
  vpc_id      = "vpc-9ba455fc" # TODO: Reference this.

  ingress {
    description = "SSH"
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_address_list_2}"]
  }

  tags {
    "Name"       = "Restricted inbound SSH"
    "Managed By" = "Terraform"
  }
}

/**
 *
 *
 * @see https://www.ibm.com/support/knowledgecenter/en/SS42VS_7.3.1/com.ibm.qradar.doc/c_DefAppCfg_guide_ICMP_intro.html
 */
resource "aws_security_group" "ping" {
  name        = "Restricted ping access"
  description = "Restricted ping access"
  vpc_id      = "vpc-9ba455fc" # TODO: Reference this.

  ingress {
    description = "Ping"
    from_port   = 8      # Echo request.
    to_port     = -1
    protocol    = "icmp"

    cidr_blocks = [
      "${var.ip_address_list_1}",
    ]
  }

  egress {
    description = "Ping"
    from_port   = 0      # Echo reply.
    to_port     = -1
    protocol    = "icmp"

    cidr_blocks = [
      "${var.ip_address_list_1}",
    ]
  }

  tags {
    "Name"       = "Restricted ping access"
    "Managed By" = "Terraform"
  }
}

resource "aws_security_group" "rdp" {
  name        = "Restricted RDP access"
  description = "Restricted RDP access"
  vpc_id      = "vpc-9ba455fc" # TODO: Reference this.

  ingress {
    description = "RDP"
    from_port   = "${var.rdp_port}"
    to_port     = "${var.rdp_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_address_list_1}"]
  }

  tags {
    "Name"       = "Restricted RDP access"
    "Managed By" = "Terraform"
  }
}
