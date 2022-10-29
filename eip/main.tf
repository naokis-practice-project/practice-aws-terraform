variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  region     = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "ec2" {
  ami           = "ami-005e54dee72cc1d00"
  instance_type = "t2.micro"
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.ec2.id
}

output "EIP" {
  value = aws_eip.elastic_ip.public_ip
}