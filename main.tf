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


data "azurerm_subnet" "subnet" {
  resource_group_name = "RG-Sairam"
  virtual_network_name = "Sai"
  name = "Subnet1"
  
}


module "rg2" {
  source = "./modules/resouce"
  rg_name = "test"
  location = "WestEurope "
}

module  "rg3"{
  source = "./modules/resouce"
  rg_name = "test2"
  location = "WestEurope "
}
module "pub" {

  source = "./modules/public ip"
  count = 3
  rg_name = module.rg2.resource_group_name
  name = "testpubic-${count.index}"
  location = "WestEurope "
  
}
module "nic1" {
  source = "./modules/nic"
  count = 2
  resource_group_name = module.rg2.resource_group_name
  location = "WestEurope "
  nic_name =  "f1-${count.index}"
  subnet_id = data.azurerm_subnet.subnet.id
  ip_name = "ip1"
  publicip = module.pub[count.index].publicipid
  
}
module "NSG" {
  source = "./modules/NSG"
  count = 3
  name = "NSG-${count.index}"
  rg_name = module.rg3.resource_group_name
  location = "WestEurope "
  
}


module "ubuntu" {
  count = 2
  source = "./modules/vms"
  name = "Linux-vm-${count.index}"
  location = "WestEurope "
  resource_group_name = module.rg3.resource_group_name
  networkids = [module.nic1[count.index].nicid]
  vm_size = "Standard_D2s_v3"
  

  
}
