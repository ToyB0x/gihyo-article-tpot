output "ssh" {
  value = "ssh -i keys/id_rsa -p 22 ubuntu@${azurerm_linux_virtual_machine.tpot.public_ip_address}"
}
