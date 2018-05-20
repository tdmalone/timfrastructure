/**
 * IAM users created for Travis CI runs on separate repositories.
 *
 * @author Tim Malone <tdmalone@gmail.com>
 * @see https://www.terraform.io/docs/providers/aws/r/iam_user.html
 * @see https://www.terraform.io/docs/providers/aws/r/iam_access_key.html
 */

resource "aws_iam_user" "travis_ci_ack" {
  name = "travis-ci-ack"
}

resource "aws_iam_user" "travis_ci_aws_billing_alerts" {
  name = "travis-ci-aws-billing-alerts"
}

resource "aws_iam_user" "travis_ci_cloudfront_security_headers" {
  name = "travis-ci-cloudfront-security-headers"
}

resource "aws_iam_user" "travis_ci_cloudwatch_to_papertrail" {
  name = "travis-ci-cloudwatch-to-papertrail"
}

resource "aws_iam_user" "travis_ci_code_build_trigger" {
  name = "travis-ci-code-build-trigger"
}

resource "aws_iam_user" "travis_ci_coffe_shop_message" {
  name = "travis-ci-coffee-shop-message"
}

resource "aws_iam_user" "travis_ci_ec2_instance_stop_start" {
  name = "travis-ci-ec2-instance-stop-start"
}

resource "aws_iam_user" "travis_ci_proximity_events_webhook_parser" {
  name = "travis-ci-proximity-events-webhook-parser"
}

resource "aws_iam_user" "travis_ci_security_group_ip_poker" {
  name = "travis-ci-security-group-ip-poker"
}

resource "aws_iam_user" "travis_ci_sftp_to_papertrail" {
  name = "travis-ci-sftp-to-papertrail"
}

resource "aws_iam_user" "travis_ci_slashiez" {
  name = "travis-ci-slashiez"
}

resource "aws_iam_user" "travis_ci_sns_to_slack" {
  name = "travis-ci-sns-to-slack"
}

resource "aws_iam_user" "travis_ci_timfrastructure" {
  name = "travis-ci-timfrastructure"
}

resource "aws_iam_user" "travis_ci_tm_id_au" {
  name = "travis-ci-tm-id-au"
}

resource "aws_iam_user" "travis_ci_travis_logs_to_papertrail" {
  name = "travis-ci-travis-logs-to-papertrail"
}
