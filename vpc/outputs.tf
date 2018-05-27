output "aws_vpc_id" {
  value = "${aws_vpc.tim_vpc.id}"
}

output "aws_subnet_public_a_id" {
  value = "${aws_subnet.public-a.id}"
}

output "aws_subnet_public_b_id" {
  value = "${aws_subnet.public-b.id}"
}

output "aws_subnet_private_b_id" {
  value = "${aws_subnet.private-b.id}"
}
