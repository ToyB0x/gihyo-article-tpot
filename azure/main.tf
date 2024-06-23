variable "admin_ip" {}
variable "vpc_cidr" {}
variable "subnet_cidr" {}
variable "azure_subscription_id" {}

# PROVIDER
provider "azurerm" {
  alias  = "jp"
  subscription_id = var.azure_subscription_id
  features {}
}

provider "azurerm" {
  alias  = "us"
  subscription_id = var.azure_subscription_id
  features {}
}

# RESOURCE GROUP
module "rg_jp" {
  name = "tpot-jp"
  source = "./rg"
  location = "Japan East"
  providers = {
    azurerm = azurerm.jp
  }
}

module "rg_us" {
  name = "tpot-us"
  location = "East US"
  source = "./rg"
  providers = {
    azurerm = azurerm.us
  }
}

# NETWORK
module "network_jp" {
  name = "tpot-jp"
  source = "./network"
  admin_ip =  var.admin_ip
  address_space =  var.vpc_cidr
  address_prefixe =  var.subnet_cidr
  location = module.rg_jp.location
  resource_group_name = module.rg_jp.resource_group_name
  providers = {
    azurerm = azurerm.jp
  }
}

module "network_us" {
  name = "tpot-us"
  source = "./network"
  admin_ip =  var.admin_ip
  address_space =  var.vpc_cidr
  address_prefixe =  var.subnet_cidr
  location = module.rg_us.location
  resource_group_name = module.rg_us.resource_group_name
  providers = {
    azurerm = azurerm.us
  }
}

# VM
module "vm_jp" {
  name = "tpot-jp"
  source = "./vm"
  location = module.rg_jp.location
  nic_id = module.network_jp.nic_id
  resource_group_name = module.rg_jp.resource_group_name
  providers = {
    azurerm = azurerm.jp
  }
}

module "vm_us" {
  name = "tpot-us"
  source = "./vm"
  location = module.rg_us.location
  nic_id = module.network_us.nic_id
  resource_group_name = module.rg_us.resource_group_name
  providers = {
    azurerm = azurerm.us
  }
}
