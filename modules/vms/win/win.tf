resource "azurerm_windows_virtual_machine" "example" {
  name                = var.name
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.size
  admin_username      = "sai"
  admin_password      = "ram@6281304637"
  network_interface_ids = var.networkids

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter-g2"
    version   = "latest"
    
  }
}