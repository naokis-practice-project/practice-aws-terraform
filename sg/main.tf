variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  region     = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_instance" "ec2" {
  ami             = "ami-005e54dee72cc1d00"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.aws_sg.name]
}

resource "aws_security_group" "aws_sg" {
  name = "Allow HTTPS"

  # 入力
  ingress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  # 出力
  egress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
}