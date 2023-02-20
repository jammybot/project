output "public_ip_1" {
  value = module.vm.public_ip_1

}

 output "public_ip_2" {
  value = module.vm.public_ip_2
} 

output "lb_dvwa_dns" {
    value = module.loadbalancer.lb_dvwa_dns
}

