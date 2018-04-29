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
