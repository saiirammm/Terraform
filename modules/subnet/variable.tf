variable "sub-name" {
    type = string 
}
variable "rg-name" {
  type = string
}
variable "vnet-name" {
  type = string
}
variable "address_prefixes" {
    type = list(string)
  
}
variable "subnet-type" {
    type = string
    default = null
    description = "Private or public By default it is public"
  
}