variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type  = string
}

variable "resource_group_name_prefix" {
  default     = "project"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

