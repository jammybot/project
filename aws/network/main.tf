
resource "aws_vpc" "project_dvwa_net" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "project_dvwa_net-vpc"
  }
}

resource "aws_subnet" "project_dvwa_subnet_1" {
  vpc_id     = aws_vpc.project_dvwa_net.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "project_dvwa_net-subnet-1"
  }
}

resource "aws_subnet" "project_dvwa_subnet_2" {
  vpc_id     = aws_vpc.project_dvwa_net.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "project_dvwa_net-subnet-2"
  }
}

resource "aws_network_interface" "aws_nic_1" {
  subnet_id       = aws_subnet.project_dvwa_subnet_1.id
  private_ips     = ["10.0.1.4"]
  security_groups = [aws_security_group.instance_sg.id]

  tags = {
    Name = "aws_nic_1"
  }
}

resource "aws_network_interface" "aws_nic_2" {
  subnet_id       = aws_subnet.project_dvwa_subnet_2.id
  private_ips     = ["10.0.2.5"]
  security_groups = [aws_security_group.instance_sg.id]

  tags = {
    Name = "aws_nic_2"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.project_dvwa_net.id

  tags = {
    Name = "gw"
  }
}

resource "aws_route" "route_table" {
  route_table_id = aws_vpc.project_dvwa_net.main_route_table_id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
  
}
resource "aws_security_group" "lb_sg" {
  name        = "lb_sg"
  description = "sg for load balancer"
  vpc_id      = aws_vpc.project_dvwa_net.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    #ip redacted
    cidr_blocks = [""]
    description = "http access"
  }
  tags = {
    Name = "lb_sg"
  }
}

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "sg for instances"
  vpc_id      = aws_vpc.project_dvwa_net.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["92.237.154.94/32","94.11.48.7/32"]
    description = "SSH access"

  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
    description = "http access to loadbalancer"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "instance_sg"
  }
}

resource "aws_security_group_rule" "lb_ingres_rule" {
  type = "egress"
  security_group_id = aws_security_group.lb_sg.id
  from_port   = 80
  to_port     = 80
  protocol    = "-1"
  source_security_group_id = aws_security_group.instance_sg.id
  description ="http access to instances"
    
}