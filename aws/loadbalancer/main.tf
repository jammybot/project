resource "aws_lb" "lb_dvwa" {
  name               = "loadbalancer-dvwa"
  load_balancer_type = "application"
  security_groups    = [var.lb_sg]
  subnets = [ var.project_dvwa_subnet_1,var.project_dvwa_subnet_2 ]
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb_dvwa.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = "dvwatg"
  port     = "80"
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200,302"
  }
}
resource "aws_lb_target_group_attachment" "tg_attach_1" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id = var.dvwa_instance_1
  
}
resource "aws_lb_target_group_attachment" "tg_attach_2" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id = var.dvwa_instance_2
}



