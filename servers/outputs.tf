output "aws_tm_id_au_external_ip" {
  value = "${aws_eip.aws-tm-id-au.public_ip}"
}
