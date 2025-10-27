output "publicipid" {
    value = azurerm_public_ip.name.id
}
output "publicip" {
    value = azurerm_public_ip.name.ip_address
  
}