output "nic_1" {
    value = aws_network_interface.aws_nic_1.id 
}

output "nic_2" {
    value = aws_network_interface.aws_nic_2.id
}

output "instance_sg"{
    value = aws_security_group.instance_sg.id
} 

output "lb_sg"{
    value = aws_security_group.lb_sg.id
}

output "project_dvwa_subnet_1" {
    value = aws_subnet.project_dvwa_subnet_1.id
}

output "project_dvwa_subnet_2" {
    value = aws_subnet.project_dvwa_subnet_2.id
}

output "vpc_id" {
  value =  aws_vpc.project_dvwa_net.id
}