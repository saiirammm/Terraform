
resource "azurerm_virtual_machine" "main" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.networkids
  vm_size               = var.vm_size

  availability_set_id = var.availability_set_id
  # Uncomment this line to delete the OS disk automatically when deleting the VM
  #delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  #delete_data_disks_on_termination = true
/*
  storage_image_reference {
    publisher = "Redhat"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
*/
  storage_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9_4"
    version   = "latest"
  }
  storage_os_disk {
    name              = var.name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "jaiMahesh"
    admin_username = "mahesh"
    admin_password = "linuxguru@123"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}