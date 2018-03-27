/**
 * DNS configuration, usually using Cloudflare.
 *
 * @see ./domains.tf
 * @see ./redirects.tf
 * @see https://www.terraform.io/docs/providers/cloudflare/r/record.html
 * @author Tim Malone <tdmalone@gmail.com>
 */

/** Domain 1. **/

# TODO:
#
# aws.tm.id.au A & MX
# CAA records
# ACM CNAMEs
# api.tm.id.au CNAME
# c9.tm.id.au CNAME (incl Cloudfront)
# naked & www CNAMEs (incl Cloudfront)
# dasher.tm.id.au CNAME
# mailgun CNAME & MX
# git.tm.id.au CNAME
# netlify.tm.id.au CNAME
# slackemon CNAMES
# MX
# SES TXT
# SPF (naked & mail)
# domainkey TXT

/** Domain 2. **/

# TODO:
#
# aws, calendar, docs, webmail CNAMEs
# MX
# SPF
# SES TXT

resource "cloudflare_record" "domain2-naked" {
  domain = "${var.domain2}"
  name   = "${var.domain2}"
  value  = "${aws_s3_bucket.domain2-naked.website_endpoint}"
  type   = "CNAME"
}

resource "cloudflare_record" "domain2-www" {
  domain = "${var.domain2}"
  name   = "www"
  value  = "${aws_s3_bucket.domain2-www.website_endpoint}"
  type   = "CNAME"
}

/** Domain 3. **/

# TODO:
#
# MX
# SPF
# SES TXT

resource "cloudflare_record" "domain3-naked" {
  domain = "${var.domain3}"
  name   = "${var.domain3}"
  value  = "${aws_s3_bucket.domain3-naked.website_endpoint}"
  type   = "CNAME"
}

resource "cloudflare_record" "domain3-www" {
  domain = "${var.domain3}"
  name   = "www"
  value  = "${aws_s3_bucket.domain3-www.website_endpoint}"
  type   = "CNAME"
}
