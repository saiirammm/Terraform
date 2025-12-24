resource "azurerm_network_interface" "nic" {
  name = var.nic_name
  resource_group_name = var.resource_group_name
  location = var.location
  
  
  accelerated_networking_enabled = true
  ip_configuration {
    name = var.ip_name
    private_ip_address_allocation = "Dynamic"
    subnet_id = var.subnet_id
    public_ip_address_id = var.publicip
    
  }
  
  
}

resource "azurerm_network_interface_security_group_association" "name" {
  count = length(var.nsgid)
  network_interface_id = azurerm_network_interface.nic.id
  network_security_group_id = var.nsgid[count.index]
}
