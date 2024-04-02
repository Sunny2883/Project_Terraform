# resource "aws_acm_certificate" "certificate" {
#   domain_name       = "example.com"
#   validation_method = "DNS"

#   tags = {
#     Environment = "test"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

resource "aws_lb" "loadbalancer" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnets
  security_groups    = var.security_groups
  
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "targetgroup1" {
  target_type = var.target_type
  name        = "targetgroup1"
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  port        = 4200
}

resource "aws_lb_target_group" "backendtargetgroup" {
  target_type = var.target_type
  name        = "backendtargetgroup"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = 4200
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetgroup1.arn
  }
}

resource "aws_lb_listener" "listener2" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = 8080  
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backendtargetgroup.arn
  }
}

# resource "aws_lb_listener_certificate" "certificate" {
#   listener_arn    = aws_lb_listener.listener.arn
#   certificate_arn = aws_acm_certificate.certificate.arn
# }