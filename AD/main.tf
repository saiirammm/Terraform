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

module "AD-RG" {
  source   = "../modules/resouce"
  rg_name  = "AD"
  location = "EastUS"
}
module "Vnet" {
  source        = "../modules/vnet"
  vnet-name     = "AD-Vnet"
  rg-name       = module.AD-RG.resource_group_name
  location      = module.AD-RG.location
  address_space = ["10.2.0.0/16"]
  dns = ["10.2.1.5"]

}
module "subnet1" {
  source           = "../modules/subnet"
  sub-name         = "vms"
  rg-name          = module.AD-RG.resource_group_name
  vnet-name        = module.Vnet.vnet-name
  address_prefixes = ["10.2.1.0/24"]

}

module "pubips" {
  source   = "../modules/public ip"
  name     = "ip2"
  rg_name  = module.AD-RG.resource_group_name
  location = module.AD-RG.location

}

module "nic-AD" {
  count               = 3
  source              = "../modules/nic"
  resource_group_name = module.AD-RG.resource_group_name
  location            = module.AD-RG.location
  nic_name            = "AD-${count.index}"
  subnet_id           = module.subnet1.subnet_id
  ip_name             = "ip-${count.index}"
  nsgid               = [module.nsg-AD[count.index].nsgid]

  publicip = count.index == 1 ? module.pubips.publicipid : null
}
module "nsg-AD" {
  count    = 3
  source   = "../modules/NSG"
  rg_name  = module.AD-RG.resource_group_name
  location = module.AD-RG.location
  name     = "nsg-${count.index}"

}
module "linux-redhat-AD" {

  source              = "../modules/vms"
  name                = "redhat-AD"
  location            = module.AD-RG.location
  resource_group_name = module.AD-RG.resource_group_name
  networkids          = [module.nic-AD[0].nicid]
  vm_size             = "Standard_D2s_v3"
  image               = "redhat"

}
module "linux-win10" {
  count      = 2
  source     = "../modules/vms/win"
  rg_name    = module.AD-RG.resource_group_name
  location   = module.AD-RG.location
  size       = "Standard_D2s_v3"
  networkids = [module.nic-AD[count.index + 1].nicid]
  name = "AD-Windows-${count.index}"

}
