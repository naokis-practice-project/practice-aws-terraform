variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  region     = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

module "ec2Module" {
  source  = "./ec2"
  ec2Name = "Name From Module"
}

output "module_output" {
  value = module.ec2Module.instance_id
}