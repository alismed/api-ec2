# Application Load Balancer
resource "aws_lb" "alb" {
  name                             = "api-alb"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.alb.id]
  subnets                          = var.subnet_ids
  enable_deletion_protection       = false
  enable_http2                     = true
  enable_cross_zone_load_balancing = true
}

resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2.arn
  }
}

resource "aws_lb_target_group" "ec2" {
  name     = "ec2-tg"
  port     = 80    # Port that EC2 is listening on
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    path                = "/"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }
}

# Attach EC2 instances to target group
resource "aws_lb_target_group_attachment" "ec2" {
  count            = length(var.subnet_ids)
  target_group_arn = aws_lb_target_group.ec2.arn
  target_id        = aws_instance.ec2[count.index].id
  port             = 80    # Port that EC2 is listening on
}
