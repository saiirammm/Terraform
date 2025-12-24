
resource "azurerm_virtual_machine" "main" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.networkids
  vm_size               = var.vm_size

  availability_set_id = var.availability_set_id
  #Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true
/*
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  
  dynamic "storage_image_reference" {
    for_each = var.image =="ubuntu" ? [1] : [0]
    content{
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
    }
  }

   dynamic "storage_image_reference" {
    for_each = var.image =="redhat" ? [1] : [0]
    content{
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9_4"
    version   = "latest"
    }
  }
  
  dynamic "storage_image_reference" {
    for_each = var.image =="win11" ? [1] : [2]
    content{
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-11"
    sku       = "21h2"
    version   = "latest"
    }
  }
*/

dynamic "storage_image_reference" {
    for_each = var.image != "" ? [1] : []

    content {
      publisher = var.image == "ubuntu"    ? "Canonical" : var.image == "redhat"    ? "redhat":var.image == "win10"     ? "MicrosoftWindowsServer" : ""
      offer     = var.image == "ubuntu"    ? "0001-com-ubuntu-server-jammy" : var.image == "redhat"    ? "rhel"   : var.image == "win10"     ? "WindowsServer"                  : ""
      sku       = var.image == "ubuntu"    ? "22_04-lts": var.image == "redhat"    ? "9_4" : var.image == "win10"     ? "2022-datacenter-g2"                        : ""
      version   = "latest"
    }
  }


  storage_os_disk {
    name              = var.name
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.image == "redhat"    ? "redhat" : var.image == "win10"    ? "win10" : ""
    admin_username = "sai"
    admin_password = "ram@6281304637"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}