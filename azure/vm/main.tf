variable "name" {}
variable "location" {}
variable "resource_group_name" {}
variable "nic_id" {}

resource "azurerm_linux_virtual_machine" "tpot" {
  name                = var.name
  computer_name = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_D4s_v3"
  admin_username      = "ubuntu"

  network_interface_ids = [
    var.nic_id,
  ]

  admin_ssh_key {
    username   = "ubuntu"
    public_key = file("${path.root}/keys/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    disk_size_gb         = 128
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
