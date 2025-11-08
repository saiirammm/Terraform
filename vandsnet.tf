module "rg" {
    source = "./modules/resouce"
    rg_name = "Natgateway"
    location = "eastUS"
  
}
module "vnet" {
    source = "./modules/vnet"
    rg-name = module.rg.resource_group_name
    vnet-name = "Nat-test"
    location = "EastUS"
    address_space = ["10.14.0.0/16"]
    dns = ["10.14.0.3","10.14.0.4"]
}

module "sub1" {
    source = "./modules/subnet"
    sub-name = "public"
    rg-name = module.rg.resource_group_name
    vnet-name = module.vnet.vnet-name
    address_prefixes = ["10.14.0.0/24"]
  
}

module "sub2" {
    source = "./modules/subnet"
    sub-name = "private"
    rg-name = module.rg.resource_group_name
    vnet-name = module.vnet.vnet-name
    subnet-type = "private"
    address_prefixes = ["10.14.1.0/24"]
  
}