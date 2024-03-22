
output "lb_id" {
  value = aws_lb.loadbalancer.id
}

output "lb_arn" {
  value = aws_lb.loadbalancer.arn
}
output "target_group_arn_1" {
  value = aws_lb_target_group.targetgroup1.arn
}
output "backendtarget_arn" {
  value = aws_lb_target_group.backendtargetgroup.arn
}

