variable "vnet-name" {
    type = string
}
variable "rg-name" {
    type = string
}
variable "location" {
    type = string
}
variable "address_space" {
    type = list(string)
}

variable "dns" {
    type = list(string)
  
}