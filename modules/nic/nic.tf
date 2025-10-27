resource "azurerm_network_interface" "nic" {
  name = var.nic_name
  resource_group_name = var.resource_group_name
  location = var.location
  ip_configuration {
    name = var.ip_name
    private_ip_address_allocation = "Dynamic"
    subnet_id = var.subnet_id
    public_ip_address_id = var.publicip

    }
  
  
}