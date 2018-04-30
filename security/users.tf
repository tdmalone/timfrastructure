/** @see https://www.terraform.io/docs/providers/aws/r/iam_user.html */

# https://www.terraform.io/docs/providers/aws/r/iam_user_login_profile.html
# https://www.terraform.io/docs/providers/aws/r/iam_access_key.html

resource "aws_iam_user" "tim" {
  name = "tim"
}

/** @see https://www.terraform.io/docs/providers/aws/r/iam_user_ssh_key.html */
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

resource "aws_iam_user" "tim_ubuntu_aws_cli_root" {
  name = "tim-aws-aws-cli-root"
}

resource "aws_iam_user" "tim_iam_tester" {
  name = "tim-iam-tester"
}

resource "aws_iam_user" "tim_iphone_app" {
  name = "tim-iphone-app"
}

resource "aws_iam_user" "tim_iphone_pocket_console" {
  name = "tim-iphone-pocket-console"
}

resource "aws_iam_user" "tim_mac_aws_cli" {
  name = "tim-mac-aws-cli"
}

resource "aws_iam_user" "tim_mac_sdb_navigator_chrome" {
  name = "SdbNavigatorChromeMac"
}

resource "aws_iam_user" "tim_windows_aws_cli" {
  name = "tim-win-aws-cli"
}

resource "aws_iam_user" "tim_windows_beyond_compare_s3" {
  name = "tim-win-beyondcompare-s3"
}

resource "aws_iam_user" "travis_ci_timfrastructure" {
  name = "travis-ci-timfrastructure"
}
