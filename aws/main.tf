module "network" {
  source = "./network"
  /* dvwa_instance_1 = module.vm.dvwa_instance_1
  dvwa_instance_2 = module.vm.dvwa_instance_2 */
}

module "loadbalancer" {
  source = "./loadbalancer"
  lb_sg = module.network.lb_sg
  project_dvwa_subnet_1 =  module.network.project_dvwa_subnet_1
  project_dvwa_subnet_2 =  module.network.project_dvwa_subnet_2
  dvwa_instance_1 = module.vm.dvwa_instance_1
  dvwa_instance_2 = module.vm.dvwa_instance_2
  vpc_id = module.network.vpc_id
}

module "vm" {
  source = "./vm"
  project_dvwa_subnet_1 =  module.network.project_dvwa_subnet_1
  project_dvwa_subnet_2 =  module.network.project_dvwa_subnet_2
  instance_sg = module.network.instance_sg
  /* nic_1 = module.network.nic_1
  nic_2 = module.network.nic_2 */

}

module "waf" {
  source = "./waf"
  lb_dvwa = module.loadbalancer.lb_dvwa
}