/**
 *
 *
 * @see https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
 */
/*
resource "aws_autoscaling_group" "default" {
  launch_configuration      = "${aws_launch_configuration.default.name}"
  max_size                  = 1
  min_size                  = 0
  metrics_granularity       = "1Minute"
  force_delete              = false
  wait_for_capacity_timeout = "10m"
}
*/
/**
 *
 *
 * @see https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
 */
/*
resource "aws_launch_configuration" "default" {
  image_id          = ""
  instance_type     = ""
  name              = "${var.server_hostname}"
  instance_type     = "${var.server_type}"
  key_name          = "${aws_key_pair.default.key_name}"
  name              = "${var.server_hostname}"
  enable_monitoring = false
  ebs_optimized     = false
}
*/

