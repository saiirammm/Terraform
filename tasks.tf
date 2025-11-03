data "azurerm_availability_set" "av" {
  resource_group_name = "Tasks"
  name = "av-set"
}

data "azurerm_resource_group" "rg-task" {
  name = "Tasks"

  
}


module "nictasks" {
  source = "./modules/nic"
  count = 3
  resource_group_name = data.azurerm_resource_group.rg-task.name
  location = "WestEurope"
  nic_name =  "task-avset-${count.index}"
  subnet_id = data.azurerm_subnet.subnet.id
  ip_name = "ip${count.index}"
}

module "tasks-ubuntu" {
  count = 3
  source = "./modules/vms"
  name = "tasks-vm-${count.index}"
  location = "WestEurope "
  resource_group_name = data.azurerm_resource_group.rg-task.name
  networkids = [module.nictasks[count.index].nicid]
  vm_size = "Standard_D2s_v3"
  availability_set_id = data.azurerm_availability_set.av.id
  
}

