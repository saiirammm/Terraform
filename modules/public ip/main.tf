resource "azurerm_public_ip" "name" {
  resource_group_name = var.rg_name
  name = var.name
  location = var.location
  allocation_method = "Static"
}