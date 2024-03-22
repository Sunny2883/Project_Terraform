provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "mainvpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  
  tags = {
    Name = var.vpc_name
  }
}



resource "aws_subnet" "public_subnets" {
 count      = length(var.cidr_block_public_subnet)
 vpc_id     = aws_vpc.mainvpc.id
 cidr_block = element(var.cidr_block_public_subnet, count.index)
 availability_zone = var.azs[count.index]
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.mainvpc.id
  tags = {
    Name="VPC internet gateway"
  }
}

resource "aws_route_table" "Project_route_table" {
 vpc_id = aws_vpc.mainvpc.id
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

