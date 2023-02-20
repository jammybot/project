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
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.privatekey)
      timeout     = "4m"
   }
   /* user_data = <<EOF
#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install docker docker.io -y 
EOF */
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
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.privatekey)
      timeout     = "4m"
   }
  /* user_data = <<EOF
#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install docker docker.io -y 
  EOF */
}
resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = file(var.public_key)
}

