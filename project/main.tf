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

/*
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

data "azurerm_subnet" sub {
  resource_group_name = "Mahesh_terraform"
  virtual_network_name = "RHEL-Vnet"
  name = "snet-westus2-1"
  
}
/*
module "pubip" {
  source = "./modules/public ip"
  name = "ip1"
  rg_name = data.azurerm_subnet.sub.resource_group_name
  location = "WestUS2"

}
module "nic" {
  source = "./modules/nic"
  nic_name = "mahesh"
  resource_group_name = data.azurerm_subnet.sub.resource_group_name
  subnet_id = data.azurerm_subnet.sub.id
  location = "WestUS2"
  ip_name = "test"
  publicip = module.pubip.publicip

  
}
module "red-hat-vm" {
  source = "./modules/vms"
  name = "redhat"
  location = "WestUS2"
  resource_group_name = data.azurerm_subnet.sub.resource_group_name
  networkids = module.nic.id
  vm_size = "Standard_D2s_V3"

  
}
*/
module "rg" {
  source = "../modules/resouce"
  rg_name = "test-aaks-module"
  location = "WestUS2"
  
}

module "aks" {
  source = "../modules/AKS"
  name = "aks-test"
  location = "WestUS2"
  resource_group_name = module.rg.resource_group_name 
}

data "azurerm_virtual_network" "vnet" {
  name = "vnet-westeurope"
  resource_group_name = "RG-TEST-01"
}




