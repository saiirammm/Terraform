variable "resource_group_name" {
    type = string
    description = "enter the resource group name"
}
variable "location" {
    type = string
  
}
variable "nic_name" {
    type = string
  
}
variable "subnet_id" {
    type = string
  
}
variable "ip_name" {
    type = string
  
}

variable "nsgid" {
    type = list(string)
    default = []
  
}
variable "publicip" {
    type = string
    default = null
  
}


