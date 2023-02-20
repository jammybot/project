variable "resource_group_name" {
  type    = string
}

variable "resource_group_location" {
  type    = string
}

variable "dvwa_nic_1" {
  type    = list(string)
}

variable "dvwa_nic_2" {
  type    = list(string)
}

variable "privatekey" {
  default = "/home/james/.ssh/james"
}

variable "public_key" {
  default = "/home/james/.ssh/james.pub"
}
variable "public_ip_1" {
  type    =   string
}
variable "public_ip_2" {
  type    =   string
}