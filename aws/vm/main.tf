resource "aws_instance" "dvwa_instance_1" {
  ami           = "ami-0d09654d0a20d3ae2"
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.id
  associate_public_ip_address = true
  subnet_id = var.project_dvwa_subnet_1
  vpc_security_group_ids = [var.instance_sg]

  tags = {
    Name = "dvwa_1"
  }

  provisioner "file" {
    source      = "./startupscript.sh"
    destination = "/tmp/startipscript.sh"
  }
  
  provisioner "remote-exec" {
    inline = ["/bin/bash /tmp/startipscript.sh"
    ]
  }

  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.privatekey)
      timeout     = "4m"
   }

  }
resource "aws_instance" "dvwa_instance_2" {
  ami           = "ami-0d09654d0a20d3ae2" 
  instance_type = "t2.micro"
  key_name = aws_key_pair.deployer.id
  associate_public_ip_address = true
  subnet_id = var.project_dvwa_subnet_2
  vpc_security_group_ids = [var.instance_sg]

  tags = {
    Name = "dvwa_2"
  }

  depends_on = [
    aws_instance.dvwa_instance_1
  ]
  
  provisioner "file" {
    source      = "./startupscript.sh"
    destination = "/tmp/startipscript.sh"
  }
  
  provisioner "remote-exec" {
    inline = ["/bin/bash /tmp/startipscript.sh"
    ]
  }

  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.privatekey)
      timeout     = "4m"
   }
}
resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = file(var.public_key)
}

