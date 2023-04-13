variable "project_dvwa_subnet_1" {
  type = string
}

variable "project_dvwa_subnet_2" {
  type = string
}

variable "privatekey" {
  default = "/home/james/.ssh/aws"
}

variable "public_key" {
  default = "/home/james/.ssh/aws.pub"
}

variable "instance_sg" {
  type  =   string
}