/**
 * Configuration for web redirects, usually via S3 buckets.
 *
 * @see ./domains.tf
 * @see ./dns.tf
 * @see https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
 * @author Tim Malone <tdmalone@gmail.com>
 */

variable "redirect_location" {
  default = "https://tm.id.au"
}

/** Domain 1. **/

/*resource "aws_s3_bucket" "domain1-www" {
  bucket = "www.${var.domain1}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = "${var.redirect_location}"
  }
}*/

/** Domain 2. **/

resource "aws_s3_bucket" "domain2-naked" {
  bucket = "${var.domain2}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = "${var.redirect_location}"
  }
}

resource "aws_s3_bucket" "domain2-www" {
  bucket = "www.${var.domain2}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = "${var.redirect_location}"
  }
}

/** Domain 3. **/

resource "aws_s3_bucket" "domain3-naked" {
  bucket = "${var.domain3}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = "${var.redirect_location}"
  }
}

resource "aws_s3_bucket" "domain3-www" {
  bucket = "www.${var.domain3}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = "${var.redirect_location}"
  }
}
