output "frontend_subnet" {
  value = azurerm_subnet.frontend_subnet.id
}

output "public_ip_1" {
    value = azurerm_public_ip.public_ip_1.ip_address
}

output "public_ip_2" {
    value = azurerm_public_ip.public_ip_2.ip_address
}

output "public_ip_3" {
    value = azurerm_public_ip.public_ip_3.id
}

output "dvwa_nic_1" {
  value = azurerm_network_interface.dvwa_nic_1.id
}

output "dvwa_nic_2" {
  value = azurerm_network_interface.dvwa_nic_2.id
}