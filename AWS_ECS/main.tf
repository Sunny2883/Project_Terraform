resource "aws_ecs_task_definition" "project_task_definition" {
  family                = "project-task-family"
  network_mode          = "bridge"
  
  container_definitions = jsonencode([
      {
      image         = var.image_url
      cpu           = tonumber(var.cpu)
      memory        = tonumber(var.memory)
      name          = var.task_name
      networkMode   = "bridge"
      portMappings  = [
        {
          containerPort = 4200
          hostPort      = 4200
        }
      ]
    }
  ])
}

resource "aws_ecs_task_definition" "backend_task_definition" {
  family                = "backend-task-family"
  network_mode          = "bridge"
  
  container_definitions = jsonencode([
    {
      image         = var.backend_image_url
      cpu           = tonumber(var.backend_cpu)
      memory        = tonumber(var.backend_memory)
      name          = var.backend_task_name
      networkMode   = "bridge"
      portMappings  = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}



resource "aws_ecs_cluster" "project_cluster" {
  name = "project_cluster"
}

resource "aws_ecs_service" "ecs_service" {
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.project_cluster.arn
  task_definition = aws_ecs_task_definition.project_task_definition.arn
  
  desired_count   = var.min_capacity

   
  
}
resource "aws_ecs_service" "backend_ecs_service" {
  name            = "backend-ecs-service"
  cluster         = aws_ecs_cluster.project_cluster.arn
  task_definition = aws_ecs_task_definition.backend_task_definition.arn
  
  desired_count   = var.backend_min_capacity
  
  
}

