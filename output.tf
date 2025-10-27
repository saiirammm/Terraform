output "ip" {
  value = module.nic1.private-ip
  
}
output "pubip" {
    value = module.pub.publicip
  
}