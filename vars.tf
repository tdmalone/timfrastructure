/**
 * Defines variables used throughout the Terraform configuration.
 *
 * @author Tim Malone <tdmalone@gmail.com>
 */

variable "domain1" {
  default = "tm.id.au"
}

variable "domain2" {
  default = "timmalone.id.au"
}

variable "domain3" {
  default = "timmalone.com.au"
}

variable "server_hostname" {
  default = "aws.tm.id.au"
}

variable "server_type" {
  default = "t2.micro"
}

variable "ssh_port" {}
variable "rdp_port" {}

variable "ip_address_list_1" {
  default = []
}

variable "ip_address_list_2" {
  default = []
}
