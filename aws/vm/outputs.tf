output "dvwa_instance_1" {
    value = aws_instance.dvwa_instance_1.id
}

output "dvwa_instance_2" {
    value = aws_instance.dvwa_instance_2.id
}

output "public_ip_1" {
  value = aws_instance.dvwa_instance_1.public_ip
}

output "public_ip_2" {
  value = aws_instance.dvwa_instance_2.public_ip
}