variable "image_url" {
  type = string
}

variable "cpu" {
  description = "CPU units for the ECS task"
  type = string
}

variable "memory" {
  description = "Memory for the ECS task (in MiB)"
 type = string
}

variable "task_name" {
  description = "Name of the ECS task"
  type = string
}


variable "min_capacity" {
  description = "Minimum capacity for Auto Scaling Group"
}

variable "max_capacity" {
  description = "Maximum capacity for Auto Scaling Group"
}


variable "backend_image_url" {
  type = string
}

variable "backend_task_name" {
  type = string
}

variable "backend_cpu" {
  type = string
}
variable "backend_memory" {
  type = string
}

variable "backend_min_capacity" {
  type = string
}

variable "target_group_arn" {
  type = string
}


variable "family_name_task1" {
  type = string
}

variable "family_name_task2" {
  type = string
}

variable "ecs_service1" {
  type = string
}

variable "ecs_service2" {
  type = string
}
variable "cluster_name" {
  
}