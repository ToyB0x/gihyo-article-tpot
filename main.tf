terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

module "aws" {
  source             = "./aws"
  allowed_account_id = var.aws_allowed_account_id
  vpc_cidr           = var.vpc_cidr
  subnet_cidr        = var.subnet_cidr
  admin_ip           = var.admin_ip
}

module "azure" {
  source                = "./azure"
  azure_subscription_id = var.azure_subscription_id
  vpc_cidr              = var.vpc_cidr
  subnet_cidr           = var.subnet_cidr
  admin_ip              = var.admin_ip
}

module "gcp" {
  source      = "./gcp"
  project_id  = var.gcp_project_id
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
  admin_ip    = var.admin_ip
}
