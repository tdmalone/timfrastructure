/**
 * Default key pair for use with EC2 instances.
 *
 * TODO: Manage application of the public_key without breaking the existing key.
 *
 * @see https://www.terraform.io/docs/providers/aws/r/key_pair.html
 */
resource "aws_key_pair" "default" {
  key_name   = "Tim's AWS key"
  public_key = ""

  #public_key ="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9RmTU2ArhbzKM14mtxQpTosFkvveokv19Lu36Ze/BlKCapknYiD7tY765ZlaC761WxuIZv0jx2JapdmJXdypjAceQvB1pbRGnwbvUVnoq7IgnbEJ1popgh0BD/TWTd2umRoPF1dSkGC+nYyDO0qKi+M2cHw35M8oNEBDRPx4u1XbwW7yEKcO66WZ/h7jWUXSanWjDn3ngOYMlRarKBMyflRsoLsdDjTZC2HfSPIDfDLuwqrm6GtFW6AsFhr7U1RdgN2FmFGEY9LYg2k2jYBGRHgcOAuTrmFRh2dUow74mmpkj9w8Ou0nKfeuRIXRHQ0Fcb8UVmSP95fzYeTJfwir5 tdmalone@gmail.com"
}
