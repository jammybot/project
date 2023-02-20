#Create Application Gateway
resource "azurerm_application_gateway" "app_gateway" {
  name                = "app_gate"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  zones               = [ "2","3" ]
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "frontend_ip"
    subnet_id = var.frontend_subnet
  }

  frontend_port {
    name = "Http"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend_ip"
    public_ip_address_id = var.public_ip_3

  }

  backend_address_pool {
    name = "backend_pool"
    
  }

  backend_http_settings {
    name                  = "http_back"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "Http_listener"
    frontend_ip_configuration_name = "frontend_ip"
    frontend_port_name             = "Http"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing_rule"
    rule_type                  = "Basic"
    http_listener_name         = "Http_listener"
    backend_address_pool_name  = "backend_pool"
    backend_http_settings_name = "http_back"
    priority = 1
  }

  waf_configuration {
    enabled             = true
    firewall_mode       = "Prevention"
    rule_set_type       = "OWASP"
    rule_set_version    = 3.2

  }
}
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "dvwa_backend_nic_1" {
  network_interface_id    = var.dvwa_nic_1
  ip_configuration_name   = "dvwa_nic_config_1"
  backend_address_pool_id = tolist(azurerm_application_gateway.app_gateway.backend_address_pool).0.id
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "dvwa_backend_nic_2" {
  network_interface_id    = var.dvwa_nic_2
  ip_configuration_name   = "dvwa_nic_config_2"
  backend_address_pool_id = tolist(azurerm_application_gateway.app_gateway.backend_address_pool).0.id
}
