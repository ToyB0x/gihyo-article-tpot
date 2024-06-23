variable "name" {}
variable "location" {}

resource "azurerm_resource_group" "tpot" {
  name     = var.name
  location = var.location
}
