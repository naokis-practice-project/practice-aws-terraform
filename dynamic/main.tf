# 変数宣言
variable "access_key" {}
variable "secret_key" {}

#　AWSとやり取りするプロバイダを構成
provider "aws" {
  region     = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

# インバウンド通信 外から内に向かって行われる通信
variable "ingressRules" {
  type    = list(number)
  # HTTP・HTTPSに限定
  default = [80, 443]
}

# アウトバウンド通信 使用しているコンピュータから外部のコンピュータにアクセスする通信
variable "egressRules" {
  type    = list(number)
  # HTTP・HTTPS・SMTP・MySQL・DNS・Default
  default = [80, 443, 25, 3306, 53, 8080]
}


# 仮想ファイアウォール EC2には必ずセキュリティグループが必要
resource "aws_security_group" "aws_sg" {
  name = "Allow HTTPS"

  # ブロック単位のループ処理
  dynamic "ingress" {
    # 変数
    iterator = port
    for_each = var.ingressRules
    content {
      # 開始ポート
      from_port = port.value

      # 終了範囲ポート
      to_port = port.value

      # 通信プロトコル
      protocol = "TCP"

      # IPアドレスの範囲 以下は全開放
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    # 変数
    iterator = port
    for_each = var.egressRules
    content {
      # 開始ポート
      from_port = port.value

      # 終了範囲ポート
      to_port = port.value

      # 通信プロトコル
      protocol = "TCP"

      # IPアドレスの範囲 以下は全開放
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

# EC2（プライベートなネットワーク空間）インスタンス構成
resource "aws_instance" "ec2" {
  # マシンイメージ
  ami           = "ami-005e54dee72cc1d00"
  instance_type = "t2.micro"

  # 仮想ファイアウォール設置
  security_groups = [aws_security_group.aws_sg.name]
}

