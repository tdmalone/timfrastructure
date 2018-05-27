/**
 * Make the remote state for ../redirects available for querying.
 *
 * @see https://www.terraform.io/docs/providers/terraform/d/remote_state.html
 */
data "terraform_remote_state" "redirects" {
  backend = "s3"

  config {
    bucket = "timfrastructure"
    key    = "redirects"
  }
}

/**
 * Make the remote state for ../aws.tm.id.au available for querying.
 *
 * @see https://www.terraform.io/docs/providers/terraform/d/remote_state.html
 */
data "terraform_remote_state" "aws_tm_id_au" {
  backend = "s3"

  config {
    bucket = "timfrastructure"
    key    = "servers/aws.tm.id.au"
  }
}
