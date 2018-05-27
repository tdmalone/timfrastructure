output "domain2_naked_endpoint" {
  value = "${aws_s3_bucket.domain2-naked.website_endpoint}"
}

output "domain2_www_endpoint" {
  value = "${aws_s3_bucket.domain2-www.website_endpoint}"
}

output "domain3_naked_endpoint" {
  value = "${aws_s3_bucket.domain3-naked.website_endpoint}"
}

output "domain3_www_endpoint" {
  value = "${aws_s3_bucket.domain3-www.website_endpoint}"
}
