/**
 * IAM user resources for human use.
 * See other files (such as ./users-travis-ci.tf) for system users.
 *
 * To unencrypt secret access keys:
 *
 *   $ terraform output tim_ubuntu_aws_cli_secret_access_key | base64 --decode | gpg
 *
 * @see https://www.terraform.io/docs/providers/aws/r/iam_user.html
 * @see https://www.terraform.io/docs/providers/aws/r/iam_user_ssh_key.html
 * @see https://www.terraform.io/docs/providers/aws/r/iam_user_login_profile.html
 * @see https://www.terraform.io/docs/providers/aws/r/iam_access_key.html
 */

resource "aws_iam_user" "tim" {
  name = "tim"
}

/** SSH key is used for CodeCommit access. */
resource "aws_iam_user_ssh_key" "tim" {
  username   = "${aws_iam_user.tim.name}"
  encoding   = "SSH"
  public_key = "${file("ssh.pub")}"
}

resource "aws_iam_user" "gabby" {
  name = "gabby"
}

resource "aws_iam_user" "tim_android_app" {
  name = "tim-android-app"
}

resource "aws_iam_user" "tim_ubuntu_aws_cli" {
  name = "tim-aws-aws-cli"
}

resource "aws_iam_access_key" "tim_ubuntu_aws_cli" {
  user    = "${aws_iam_user.tim_ubuntu_aws_cli.name}"
  pgp_key = "keybase:${var.keybase_username}"
}

output "tim_ubuntu_aws_cli_access_key_id" {
  value = "${aws_iam_access_key.tim_ubuntu_aws_cli.id}"
}

output "tim_ubuntu_aws_cli_secret_access_key" {
  value = "${aws_iam_access_key.tim_ubuntu_aws_cli.encrypted_secret}"
}

resource "aws_iam_user" "tim_ubuntu_aws_cli_root" {
  name = "tim-aws-aws-cli-root"
}

/** An account for the purposes of testing IAM policies and such. */
resource "aws_iam_user" "tim_iam_tester" {
  name = "tim-iam-tester"
}

resource "aws_iam_user" "tim_iphone_app" {
  name = "tim-iphone-app"
}

resource "aws_iam_user" "tim_iphone_pocket_console" {
  name = "tim-iphone-pocket-console"
}

resource "aws_iam_user" "mac_stacktray" {
  name = "mac-stacktray"
}
