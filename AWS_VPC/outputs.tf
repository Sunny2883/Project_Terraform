output "subnet" {
  value = aws_subnet.public_subnets[*].id
}

output "vpc_id" {
  value = aws_vpc.VPC_main.id
}
