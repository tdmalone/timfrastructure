/**
 * Manages the default VPC that exists in each region of every AWS account!
 *
 * @see https://www.terraform.io/docs/providers/aws/r/default_vpc.html
 */

resource "aws_default_vpc" "default" {
  tags {
    "Name"       = "Default VPC"
    "Managed By" = "Terraform"
  }
}

# TODO:
# aws_default_network_acl
# aws_default_route_table
# aws_default_security_group
# aws_default_subnet

resource "aws_default_network_acl" "default" {
  default_network_acl_id = "${aws_default_vpc.default.default_network_acl_id}"

  subnet_ids = [
    "subnet-3d8b325a",
    "subnet-77ded62e",
    "subnet-3eaa0177",
  ]

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    "Name"       = "Default VPC"
    "Managed By" = "Terraform"
  }
}
