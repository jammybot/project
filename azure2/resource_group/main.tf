#Create Resource Group and set location in variables file
resource "azurerm_resource_group" "project_dvwa" {
  location = "uksouth"
  name     = "project_dvwa"
}