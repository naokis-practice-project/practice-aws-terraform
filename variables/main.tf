variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  region     = "eu-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

variable "vpc_name" {
  type    = string
  default = "my_vpc"
}

variable "ssh_port" {
  type    = number
  default = 22
}

variable "enabled" {
  default = true
}

variable "my_list" {
  type    = list(string)
  default = ["value1", "value2"]
}

variable "my_map" {
  type    = map
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}

variable "input_name" {
  type        = string
  description = "Set the name of the VPC"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.input_name
  }
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

variable "my_tuple" {
  type    = tuple([string, number, string])
  default = ["cat", 1, "dog"]
}

variable "my_object" {
  type = object(
    {
      name = string
      port = list(number)
    })
  default = {
    name = "TJ"
    port =[22, 25, 80]
  }
}