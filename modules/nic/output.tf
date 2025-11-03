output "private-ip" {
    value = azurerm_network_interface.nic.private_ip_address
}
output "nicid" {
    value = azurerm_network_interface.nic.id
  
}