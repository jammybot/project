output "lb_dvwa" {
  value =   aws_lb.lb_dvwa.arn
}

output "lb_dvwa_dns" {
  value =   aws_lb.lb_dvwa.dns_name
}