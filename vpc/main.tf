# VPC Creation
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}_public_subnet_${count.index + 1}"
  }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnets)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.vpc_name}_private_subnet_${count.index + 1}"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.vpc_name}_igw"
  }
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.vpc_name}_public_route_table"
  }
}

# Associate Public Subnets with Route Table
resource "aws_route_table_association" "public_route_assoc" {
  count        = length(var.public_subnets)
  subnet_id    = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
    domain = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "${var.vpc_name}_nat_gw"
  }
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.vpc_name}_private_route_table"
  }
}

# Associate Private Subnets with Route Table
resource "aws_route_table_association" "private_route_assoc" {
  count        = length(var.private_subnets)
  subnet_id    = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

# Subnet Group for Database (RDS)
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.vpc_name}_db_subnet_group"
  subnet_ids = concat(aws_subnet.private_subnet[*].id)

  tags = {
    Name = "${var.vpc_name}_db_subnet_group"
  }
}

resource "aws_security_group" "secgroup" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = var.security_group_name
  }
} 


resource "aws_security_group_rule" "ingress" {
  type      = "ingress"
  for_each  = toset(var.inport)
  from_port = each.value
  to_port   = each.value
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.secgroup.id
}
resource "aws_security_group_rule" "egress" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.secgroup.id
}
