resource "azurerm_virtual_network" "vnet" {
  name = var.vnet-name
  location = var.location
  resource_group_name = var.rg-name
  address_space       = var.address_space
  dns_servers         = var.dns

}