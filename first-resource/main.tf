variable "access_key" {}
variable "secret_key" {}

# provider（どのクラウド環境を使うか）の設定
provider "aws" {
  region     = "ap-northeast-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# VPCで個別の仮想ネットワークを構築
resource "aws_vpc" "myVpc" {
  #  使用可能なIPアドレスの範囲をCIDR（サイダー）形式で指定
  #  65,536個のIPアドレスが利用できる
  cidr_block = "10.0.0.0/16"
}