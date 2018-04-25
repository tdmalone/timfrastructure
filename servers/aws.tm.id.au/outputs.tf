output "aws_tm_id_au_external_ip" {
  value = "${aws_eip.aws-tm-id-au.public_ip}"
}

output "aws_tm_id_au_internal_ip" {
  value = "${aws_eip.aws-tm-id-au.private_ip}"
}

output "xenial_tm_id_au_external_ip" {
  value = "${aws_eip.xenial_tm_id_au.public_ip}"
}

output "xenial_tm_id_au_internal_ip" {
  value = "${aws_eip.xenial_tm_id_au.private_ip}"
}
