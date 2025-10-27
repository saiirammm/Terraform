terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 1.0.4"
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
  location = "EastUS"
}

module  "rg3"{
  source = "./modules/resouce"
  rg_name = "test2"
  location = "EastUS"
}
module "pub" {
  source = "./modules/public ip"
  rg_name = module.rg2.resource_group_name
  name = "testpubic"
  location = "WestEurope"
  
}
module "nic1" {
  source = "./modules/nic"
  resource_group_name = module.rg2.resource_group_name
  location = "WestEurope"
  nic_name =  "f1"
  subnet_id = data.azurerm_subnet.subnet.id
  ip_name = "ip1"
  publicip = module.pub.publicipid
  

}
