resource "aws_launch_template" "tempelate_asg" {
  name_prefix = "asg_tempelate"
  image_id = var.iamge_id
  instance_type = var.instance_type
  user_data = var.user_data
  key_name = var.keyname
  iam_instance_profile {
    name = "ecsInstanceRole"
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.security_group_id]
  
  }
}

resource "aws_autoscaling_group" "bar" {
  name                      = var.asg_name
  max_size                  = var.max_size
  min_size                  = var.min_size
  health_check_grace_period = 300
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  force_delete              = true
  vpc_zone_identifier = var.subnet
  target_group_arns = [var.target_group_arn]
  
launch_template {
    id      = aws_launch_template.tempelate_asg.id
    version = "$Latest"

  }
}

resource "aws_autoscaling_attachment" "this" {
  autoscaling_group_name = aws_autoscaling_group.bar.id
  lb_target_group_arn    = var.alb_arn
}
