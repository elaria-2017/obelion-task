output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

output "public_subnets" {
  description = "List of Public Subnet IDs"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnets" {
  description = "List of Private Subnet IDs"
  value       = aws_subnet.private_subnet[*].id
}

output "subnet_group" {
value = aws_db_subnet_group.db_subnet_group.name  
}

output "sg_id" {
value =   aws_security_group.secgroup.id
}