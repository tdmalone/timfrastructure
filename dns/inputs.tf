data "terraform_remote_state" "redirects" {
  backend = "s3"

  config {
    bucket = "timfrastructure"
    key    = "redirects"
  }
}
