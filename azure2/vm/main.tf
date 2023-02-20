# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group_name = var.resource_group_name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "project_dvwa" {
  name                     = "diag${random_id.random_id.hex}"
  location                 = var.resource_group_location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "dvwa_vm_1" {
  name                  = "dvwa_vm_1"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.dvwa_nic_1
  size                  = "Standard_B1ls"
  zone                  = 2
  os_disk {
    name                 = "dvwa_disk_1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "myvm"
  admin_username                  = "james"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "james"
    public_key = file(var.public_key)
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.project_dvwa.primary_blob_endpoint
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt update",
      "sudo apt update",
      "sudo apt install docker docker.io -y",
      "sudo docker pull jibba/web-dvwa:project",
      "sudo docker run -d -it -p 80:80 jibba/web-dvwa:project"
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip_address
      user        = "james"
      private_key = file(var.privatekey)
      timeout     = "4m"
   }
}

resource "azurerm_linux_virtual_machine" "dvwa_vm_2" {
  name                  = "dvwa_vm_2"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.dvwa_nic_2
  size                  = "Standard_B1ls"
  zone                  = 3

  os_disk {
    name                 = "dvwa_disk_2"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "myvm"
  admin_username                  = "james"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "james"
    public_key = file(var.public_key)
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.project_dvwa.primary_blob_endpoint
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt update",
      "sudo apt update",
      "sudo apt install docker docker.io -y",
      "sudo docker pull jibba/web-dvwa:project",
      "sudo docker run -d -it -p 80:80 jibba/web-dvwa:project"
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip_address
      user        = "james"
      private_key = file(var.privatekey)
      timeout     = "4m"
   }
}

/* resource "null_resource" "execute" {
  connection {
    type        =   "ssh"
    agent       =   false
    user        =   "james"
    host        =   var.public_ip_1
    private_key =   file(var.privatekey)
    timeout     =   "4m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt update",
      "sudo apt update",
      "sudo apt install docker docker.io -y",
      "sudo docker pull jibba/web-dvwa:project",
      "sudo docker run -d -it -p 80:80 jibba/web-dvwa:project"
    ]
  }

depends_on = [azurerm_linux_virtual_machine.dvwa_vm_1]
}

resource "null_resource" "execute_2" {
  connection {
    type        =   "ssh"
    agent       =   false
    user        =   "james"
    host        =   var.public_ip_2
    private_key =   file(var.privatekey)
    timeout     = "4m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt update",
      "sudo apt update",
      "sudo apt install docker docker.io -y",
      "sudo docker pull jibba/web-dvwa:project",
      "sudo docker run -d -it -p 80:80 jibba/web-dvwa:project"
    ]
  }

depends_on = [azurerm_linux_virtual_machine.dvwa_vm_2]
} */

