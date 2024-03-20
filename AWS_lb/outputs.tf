
output "lb_id" {
  value = aws_alb.name.id
}

output "lb_arn" {
  value = aws_alb.name.arn
}
output "target_group_arn_1" {
  value = aws_alb_target_group.this.arn
}
output "backendtarget_arn" {
  value = aws_lb_target_group.backend_target_group.arn
}