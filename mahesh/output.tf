output "pub" {
    value = module.pubip.publicip
  
}
output "private" {
    value = module.nic.private-ip
}