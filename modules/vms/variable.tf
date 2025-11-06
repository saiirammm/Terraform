variable "name" {
    type = string
  
}
variable "location" {
    type = string
}
variable "resource_group_name" {
    type = string
}
variable "networkids" {
  type = list(string)
}
variable "vm_size" {
    type = string
  
}
variable "availability_set_id" {
    type = string
    default = null
  
}
variable "image" {
    type = list(string) 
}