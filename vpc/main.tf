/**
 * Manages the main VPC used by almost all the things.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/vpc.html
 * @see https://www.terraform.io/docs/providers/aws/r/subnet.html
 */
resource "aws_vpc" "tim_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public-a" {
  vpc_id            = "${aws_vpc.tim_vpc.id}"
  availability_zone = "ap-southeast-2a"
  cidr_block        = "10.0.0.0/24"
}

resource "aws_subnet" "public-b" {
  vpc_id            = "${aws_vpc.tim_vpc.id}"
  availability_zone = "ap-southeast-2b"
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "private-b" {
  vpc_id            = "${aws_vpc.tim_vpc.id}"
  availability_zone = "ap-southeast-2b"
  cidr_block        = "10.0.2.0/24"
}

# TODO:
# aws_network_acl
# aws_network_interface?
# aws_network_interface_attachment?
# aws_route_table
# aws_route_table_association

/**
 * Manage the default VPC that exists in each region of every AWS account!
 *
 * @see https://www.terraform.io/docs/providers/aws/r/default_vpc.html
 */
resource "aws_default_vpc" "default" {}

# TODO:
# aws_default_network_acl
# aws_default_route_table
# aws_default_security_group
# aws_default_subnet

