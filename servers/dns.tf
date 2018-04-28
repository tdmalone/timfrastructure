resource "cloudflare_record" "aws_tm_id_au" {
  domain = "tm.id.au"
  name   = "aws.tm.id.au"
  value  = "${aws_eip.aws-tm-id-au.public_ip}"
  type   = "A"
}

resource "cloudflare_record" "aws_int_tm_id_au" {
  domain = "tm.id.au"
  name   = "aws.int.tm.id.au"
  value  = "${aws_eip.aws-tm-id-au.private_ip}"
  type   = "A"
}

resource "cloudflare_record" "xenial_tm_id_au" {
  domain = "tm.id.au"
  name   = "xenial.tm.id.au"
  value  = "${aws_instance.xenial_tm_id_au.public_ip}"
  type   = "A"
}

resource "cloudflare_record" "xenial_int_tm_id_au" {
  domain = "tm.id.au"
  name   = "xenial.int.tm.id.au"
  value  = "${aws_instance.xenial_tm_id_au.private_ip}"
  type   = "A"
}

resource "cloudflare_record" "centos_tm_id_au" {
  domain = "tm.id.au"
  name   = "centos.tm.id.au"
  value  = "${aws_instance.centos_tm_id_au.public_ip}"
  type   = "A"
}

resource "cloudflare_record" "centos_int_tm_id_au" {
  domain = "tm.id.au"
  name   = "centos.int.tm.id.au"
  value  = "${aws_instance.centos_tm_id_au.private_ip}"
  type   = "A"
}
