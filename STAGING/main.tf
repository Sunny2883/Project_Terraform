terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "../AWS_VPC"
  cidr_block = "192.168.0.0/16"
  cidr_block_public_subnet= ["192.168.1.0/24", "192.168.2.0/24"]
  azs = ["ap-south-1a", "ap-south-1b"]
  vpc_name = "VPC_main_staging"
}

module "security_group" {
  source = "../Security_group"
  vpc_id = module.vpc.vpc_id
  Security_group_name = "ecs-security-group_staging"
}

module "aws_lb" {
  source = "../AWS_lb"
  name = "aws-lb-staging"
  subnets = module.vpc.subnet
  security_groups = [module.security_group.security_group_id]
  target_type = "instance"
  vpc_id = module.vpc.vpc_id
}

module "asg" {
  source = "../AWS_ASG"
  iamge_id = "ami-0253000eaaef5fbc5"
  depends_on = [ module.aws_lb ]
  instance_type = "t3.small"
  asg_name = "asg_for_project_staging"
  alb_arn = module.aws_lb.target_group_arn
  min_size = 0
  max_size = 1
  desired_capacity = 1
  health_check_type = "EC2"
  load_balancer = module.aws_lb.lb_id
  security_group_id = module.security_group.security_group_id
  subnet = module.vpc.subnet
  user_data = filebase64("./userdata.sh")
  target_group_arn = module.aws_lb.target_group_arn
  keyname = "projectKey"
}

module "ecs" {
  source = "../AWS_ECS"
  cluster_name = "project_cluster_staging"
  family_name_task1 = "project-task-family_staging"
  family_name_task2 = "backend_task_family_staging"
  image_url = "730335487196.dkr.ecr.ap-south-1.amazonaws.com/project_repo:latest"
  min_capacity=1
  task_name="project_task_definition_staging"
  max_capacity = 1
  cpu = 1000
  memory = 1000
  backend_image_url = "730335487196.dkr.ecr.ap-south-1.amazonaws.com/project_repo_dotnet:latest"
  backend_task_name = "dotnet_app_staging"
  backend_cpu = 300
  backend_memory = 300
  backend_min_capacity = 1
  ecs_service1 = "ecs_service_staging"
  ecs_service2 = "backend_ecs_service_staging"
  target_group_arn = module.aws_lb.target_group_arn
}