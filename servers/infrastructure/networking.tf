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
 * Elastic IP addresses for upcoming Ubuntu main + CentOS test server.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/eip.html
 */
resource "aws_eip" "ubuntu_tm_id_au" {
  instance = "${aws_instance.ubuntu_tm_id_au.id}"
  vpc      = true

  tags {
    "Name"       = "ubuntu.tm.id.au"
    "Managed By" = "Terraform"
  }
}

resource "aws_eip" "centos_tm_id_au" {
  instance = "${aws_instance.centos_tm_id_au.id}"
  vpc      = true

  tags {
    "Name"       = "centos.tm.id.au"
    "Managed By" = "Terraform"
  }
}
