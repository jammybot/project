module "resource_group" {
  source = "./resource_group"
}

module "network" {
  source = "./network"
  resource_group_name = module.resource_group.resource_group_name
  resource_group_location = module.resource_group.resource_group_location
}

module "app_gate" {
  source = "./application_gate"
  public_ip_3 = module.network.public_ip_3
  frontend_subnet = module.network.frontend_subnet
  resource_group_name = module.resource_group.resource_group_name
  resource_group_location = module.resource_group.resource_group_location
  dvwa_nic_1 = module.network.dvwa_nic_1
  dvwa_nic_2 = module.network.dvwa_nic_2
}

module "vm" {
  source = "./vm"
  dvwa_nic_1 = [module.network.dvwa_nic_1]
  dvwa_nic_2 = [module.network.dvwa_nic_2]
  resource_group_name = module.resource_group.resource_group_name
  resource_group_location = module.resource_group.resource_group_location
  public_ip_1 = module.network.public_ip_1
  public_ip_2 = module.network.public_ip_2
}

