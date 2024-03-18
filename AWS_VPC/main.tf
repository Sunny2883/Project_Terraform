provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "VPC_main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "VPC_main"
  }
}



resource "aws_subnet" "public_subnets" {
 count      = length(var.cidr_block_public_subnet)
 vpc_id     = aws_vpc.VPC_main.id
 cidr_block = element(var.cidr_block_public_subnet, count.index)
 availability_zone = var.azs[count.index]
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.VPC_main.id
  tags = {
    Name="VPC internet gateway"
  }
}

resource "aws_route_table" "Project_route_table" {
 vpc_id = aws_vpc.VPC_main.id
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.internet_gateway.id
 }
 
 tags = {
   Name = " Route Table"
 }
}


resource "aws_route_table_association" "route_table_association" {
  count = length(var.cidr_block_public_subnet)
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.Project_route_table.id
}

