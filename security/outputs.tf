output "aws_security_group_default_id" {
  value = "${aws_security_group.default.id}"
}

output "aws_security_group_outbound_id" {
  value = "${aws_security_group.outbound.id}"
}

output "aws_security_group_https_id" {
  value = "${aws_security_group.https.id}"
}

output "aws_security_group_ssh_id" {
  value = "${aws_security_group.ssh.id}"
}

output "aws_security_group_ping_id" {
  value = "${aws_security_group.ping.id}"
}
