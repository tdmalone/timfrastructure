# EC2
# CloudWatch alarms
# Datadog?
# AMIs
# snapshots
# volumes
# eips
# key pair
/*
resource "aws_instance" "ansible" {
  ami = "ami-c9c403ab" # Ansible Tower 3.2.3 on CentOS 7 as recommended at https://www.ansible.com/products/tower/trial
  instance_type = "t2.micro"
  subnet_id = "subnet-dc832995"
  tags {
    Name = "ansible.tm.id.au"
  }
}
*/

