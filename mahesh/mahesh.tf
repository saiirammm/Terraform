terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 2.0"
    }
  }
}

provider "azurerm" {
 features {} 
 subscription_id = "f88de9d1-2f8a-4973-a97d-883dcf49367c"
}


data "azurerm_subnet" sub {
  resource_group_name = "Mahesh_terraform"
  virtual_network_name = "RHEL-Vnet"
  name = "snet-westus2-1"
  
}
module "pubip" {
  source = "./TerraformFull/modules/public ip"
  name = "ip1"
  rg_name = data.azurerm_subnet.sub.resource_group_name
  location = "WestUS2"

}
module "nic" {
  source = "./TerraformFull/modules/nic"
  nic_name = "mahesh2"
  resource_group_name = data.azurerm_subnet.sub.resource_group_name
  subnet_id = data.azurerm_subnet.sub.id
  location = "WestUS2"
  ip_name = "test"
  publicip = module.pubip.publicipid

  
}
module "red-hat-vm" {
  source = "./TerraformFull/modules/vms"
  name = "redhat"
  location = "WestUS2"
  resource_group_name = data.azurerm_subnet.sub.resource_group_name
  networkids = [module.nic.nicid]
  vm_size = "Standard_D2s_V3"

  
}

module "nsg-mahesh" {
  source = "./TerraformFull/modules/NSG"
  name = "mahesh_nsg"
   rg_name = data.azurerm_subnet.sub.resource_group_name
   location = "WestUS2"
}

