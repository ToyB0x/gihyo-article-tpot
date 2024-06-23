variable "name" {}
variable "location" {}
variable "address_space" {}
variable "resource_group_name" {}
variable "address_prefixe" {}
variable "admin_ip" {}

resource "azurerm_virtual_network" "tpot" {
  name                = var.name
  address_space       = [var.address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "tpot" {
  name                 = var.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.tpot.name
  address_prefixes     = [var.address_prefixe]
}

resource "azurerm_network_security_group" "tpot" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "admin_ssh" {
  name                        = "admin-ssh"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "64295"
  source_address_prefix       = var.admin_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.tpot.name
}

resource "azurerm_network_security_rule" "admin_web" {
  name                        = "admin-web"
  priority                    = 1002
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "64297"
  source_address_prefix       = var.admin_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.tpot.name
}

resource "azurerm_network_security_rule" "tpot_all" {
  name                        = "allow-tpot-trafic"
  priority                    = 1003
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "0-64000"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.tpot.name
}

resource "azurerm_network_interface_security_group_association" "tpot" {
  network_interface_id      = azurerm_network_interface.tpot.id
  network_security_group_id = azurerm_network_security_group.tpot.id
}

resource "azurerm_public_ip" "tpot" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "tpot" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.tpot.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.tpot.id
  }
}
