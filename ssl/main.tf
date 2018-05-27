/**
 * Defines main tm.id.au wildcard SSL certificate.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/acm_certificate.html
 */
resource "aws_acm_certificate" "tm-id-au" {
  domain_name               = "tm.id.au"
  validation_method         = "DNS"
  subject_alternative_names = ["*.tm.id.au"]
}

# TODO: Add LetsEncrypt cert for aws.tm.id.au, dasher.tm.id.au and slashies.tm.id.au.
#       Alternatively replace with a wildcard LE cert.

