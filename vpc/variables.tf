# VPC CIDR
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# VPC Name
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

# Public Subnets
variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

# Private Subnets
variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

# Availability Zones
variable "azs" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}

variable "security_group_name" {
  
}

variable "inport" {
  
}
