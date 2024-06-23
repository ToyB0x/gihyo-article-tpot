variable "admin_ip" {}
variable "vpc_cidr" {}
variable "subnet_cidr" {}
variable "allowed_account_id" {}

# PROVIDER
provider "aws" {
  alias  = "jp"
  region = "ap-northeast-1"
  allowed_account_ids = [var.allowed_account_id]
}

provider "aws" {
  alias  = "us"
  region = "us-east-1"
  allowed_account_ids = [var.allowed_account_id]
}

# NETWORK
module "network_jp" {
  name = "tpot-jp"
  source = "./network"
  admin_ip =  var.admin_ip
  vpc_cidr =  var.vpc_cidr
  subnet_cidr =  var.subnet_cidr
  providers = {
    aws = aws.jp
  }
}

module "network_us" {
  name = "tpot-us"
  source = "./network"
  admin_ip =  var.admin_ip
  vpc_cidr =  var.vpc_cidr
  subnet_cidr =  var.subnet_cidr
  providers = {
    aws = aws.us
  }
}

# EC2
module "ec2_jp" {
  name = "tpot-jp"
  source = "./ec2"
  ami = "ami-0d3f6ef187d45e04b" // ap-northeast-1: ubuntu 22.04
  subnet_id = module.network_jp.subnet_id
  vpc_security_group_id = module.network_jp.vpc_security_group_id
  providers = {
    aws = aws.jp
  }
}

module "ec2_us" {
  name = "tpot-us"
  source = "./ec2"
  ami = "ami-0975ad60e5054592a" // ap-northeast-1: ubuntu 22.04
  subnet_id = module.network_us.subnet_id
  vpc_security_group_id = module.network_us.vpc_security_group_id
  providers = {
    aws = aws.us
  }
}
