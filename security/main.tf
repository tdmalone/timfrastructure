# IAM - access keys, users, groups, policies and roles
# CloudTrail
# Config?
# GuardDuty?
# Inspector?

/**
 * Defines EC2 security groups.
 *
 * @author Tim Malone <tdmalone@gmail.com>
 * @see https://www.terraform.io/docs/providers/aws/r/security_group.html
 */

resource "aws_security_group" "default" {
  description = "default VPC security group"

  ingress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    self      = true
  }
}

resource "aws_security_group" "outbound" {
  description = "Unrestricted outbound"

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "blank" {
  description = "Blank Security Group (no access)"
}

resource "aws_security_group" "https" {
  description = "Restricted inbound HTTP/HTTPS"

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
}

resource "aws_security_group" "ssh" {
  description = "Restricted inbound SSH"

  ingress {
    description = "SSH"
    from_port   = "${var.ssh_port}"
    to_port     = "${var.ssh_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_address_list_2}"]
  }
}

/**
 *
 *
 * @see https://www.ibm.com/support/knowledgecenter/en/SS42VS_7.3.1/com.ibm.qradar.doc/c_DefAppCfg_guide_ICMP_intro.html
 */
resource "aws_security_group" "ping" {
  description = "Restricted ping access"

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
}

resource "aws_security_group" "rdp" {
  description = "Restricted RDP access"

  ingress {
    description = "RDP"
    from_port   = "${var.rdp_port}"
    to_port     = "${var.rdp_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_address_list_1}"]
  }
}
