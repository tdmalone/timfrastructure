resource "aws_ebs_volume" "data" {
  availability_zone = "ap-southeast-2a"
  size              = 5
  encrypted         = true
  type              = "gp2"

  tags {
    "Name"       = "Tim Data"
    "Managed By" = "Terraform"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = "${aws_ebs_volume.data.id}"
  instance_id = "${aws_instance.aws-tm-id-au.id}"
}
