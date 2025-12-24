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
 subscription_id = "0e9784a1-7ffb-4ad5-824f-2aaa98c41256"
}



module "rg" {
  source = "../modules/resouce"
  rg_name = "test-aaks-module"
  location = "WestUS2"
  
}
module "Vnet" {
  source        = "../modules/vnet"
  vnet-name     = "AD-Vnet"
  rg-name       = module.rg.resource_group_name
  location      = module.rg.location
  address_space = ["10.2.0.0/16"]
  dns           = ["10.2.0.5","10.2.0.6"]

}
module "subnet1" {
  source           = "../modules/subnet"
  sub-name         = "vms"
  rg-name          = module.rg.resource_group_name
  vnet-name        = module.rg.location
  address_prefixes = ["10.2.1.0/24"]

}

module "pubip" {
  source = "./modules/public ip"
  name = "ip1"
  rg_name =module.rg.resource_group_name
  location = module.rg.location

}
module "nic" {
  source = "./modules/nic"
  nic_name = "mahesh"
  resource_group_name = module.rg.resource_group_name
  subnet_id = module.Subnet1.id
  location = module.rg.location
  ip_name = "test"
  publicip = module.pubip.publicip

  
}
module "ubuntu-vm" {
  source = "./modules/vms"
  count = 2
  name = "ubuntu-${i}"
  location = "WestUS2"
  resource_group_name = data.azurerm_subnet.sub.resource_group_name
  networkids = module.nic.id
  vm_size = "Standard_D2s_V3"

  
}