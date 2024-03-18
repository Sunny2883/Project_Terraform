variable "name" {
  description = "Name of the load balancer"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs for the load balancer"
  type        = list(string)
}

variable "target_type" {
  description = "ARN of the target group to associate with the load balancer"
  type        = string
}
variable "vpc_id" {
  type = string
}
