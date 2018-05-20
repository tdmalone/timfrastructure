/**
 * Assorted IAM users for system purposes.
 *
 * @author Tim Malone <tdmalone@gmail.com>
 * @see https://www.terraform.io/docs/providers/aws/r/iam_user.html
 * @see https://www.terraform.io/docs/providers/aws/r/iam_access_key.html
 */

resource "aws_iam_user" "slackemon_assets" {
  name = "slackemon-assets"
}
