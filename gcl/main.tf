
module "network" {
  source = "./network"
}

module "load_balancer" {
  source = "./load_balancer"
  instance_group = module.vm.instance_group
  public_ip = module.network.public_ip
}

module "waf" {
  source = "./waf"
}

module "vm" {
  source = "./vm"
  /* nic_1 = module.network.nic_1*/
  nic_2 = module.network.nic_2 
}
