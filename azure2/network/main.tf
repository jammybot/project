# Create virtual network
resource "azurerm_virtual_network" "dvwa_network_1" {
  name                = "dvwa_network_1"
  address_space       = ["10.0.0.0/16"]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

# Create subnets
resource "azurerm_subnet" "dvwa_subnet_1" {
  name                 = "dvwa_subnet_1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.dvwa_network_1.name
  address_prefixes     = ["10.0.1.0/24"]
 }

resource "azurerm_subnet" "dvwa_subnet_2" {
  name                 = "dvwa_subnet_2"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.dvwa_network_1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "frontend_subnet" {
  name                 = "frontend_subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.dvwa_network_1.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "public_ip_1" {
  name                = "public_ip_1"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  zones               = ["2"]
  sku                 = "Standard"
}

resource "azurerm_public_ip" "public_ip_2" {
  name                = "public_ip_2"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  zones               = ["3"]
  sku                 = "Standard"
  
}

# Public ip for the load balencer
resource "azurerm_public_ip" "public_ip_3" {
  name                = "public_ip_3"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = [ 2,3 ]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "project_nsg_1" {
  name                = "project_nsg_1"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    #ip redacted
    source_address_prefixes = [""]
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "dvwa_nic_1" {
  name                = "dvwa_nic_1"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "dvwa_nic_config_1"
    subnet_id                     = azurerm_subnet.dvwa_subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_1.id
  }
}
resource "azurerm_network_interface" "dvwa_nic_2" {
  name                = "dvwa_nic_2"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "dvwa_nic_config_2"
    subnet_id                     = azurerm_subnet.dvwa_subnet_2.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_2.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg_1" {
  network_interface_id      = azurerm_network_interface.dvwa_nic_1.id
  network_security_group_id = azurerm_network_security_group.project_nsg_1.id
}
resource "azurerm_network_interface_security_group_association" "nsg_2" {
  network_interface_id      = azurerm_network_interface.dvwa_nic_2.id
  network_security_group_id = azurerm_network_security_group.project_nsg_1.id
}
