/*
TODO: Complete this config, and also add CodeBuild etc.
*/
/*
resource "aws_instance" "jenkins" {
  ami           = "ami-beae57dc" # Jenkins-2.46.2 for Ubuntu 16.04.
  instance_type = "t2.micro"
  subnet_id     = "subnet-dc832995"
  tags {
    Name = "jenkins.tm.id.au"
  }
}
*/
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

