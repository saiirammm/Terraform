resource "azurerm_subnet" "subnet" {
  name = var.sub-name
  resource_group_name = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = var.address_prefixes

  private_endpoint_network_policies = var.subnet-type =="private" ? "Enabled" : "Disabled"
  private_link_service_network_policies_enabled = var.subnet-type=="private" ? true : false
}