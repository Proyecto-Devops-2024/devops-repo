variable "environments" {
  description = "Definición de ambientes"
  type = map(object({
    cidr_block      = string
    subnet_cidr     = string
    availability_zone = string
  }))
  default = {
    dev = {
      cidr_block         = "10.1.0.0/16"
      subnet_cidr        = "10.1.1.0/24"
      availability_zone  = "us-east-1a"
    },
    test = {
      cidr_block         = "10.2.0.0/16"
      subnet_cidr        = "10.2.1.0/24"
      availability_zone  = "us-east-1b"
    },
    prod = {
      cidr_block         = "10.3.0.0/16"
      subnet_cidr        = "10.3.1.0/24"
      availability_zone  = "us-east-1c"
    }
  }
}

# Resource Block
# Resource-1: Crear VPC
resource "aws_vpc" "vpc-ecs" {
  for_each = var.environments

  cidr_block = each.value.cidr_block

  tags = {
    "Name" = "vpc-ecs-${each.key}"
  }
}

# Resource-2: Crear Subnets
resource "aws_subnet" "vpc-ecs-public-subnet" {
  for_each = var.environments

  vpc_id = aws_vpc.vpc-ecs[each.key].id
  cidr_block = each.value.subnet_cidr
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    "Name" = "subnet-ecs-${each.key}"
  }
}

# Resource-3: Crear Internet Gateway
resource "aws_internet_gateway" "vpc-ecs-igw" {
  for_each = var.environments

  vpc_id = aws_vpc.vpc-ecs[each.key].id
}

# Resource-4: Crear Route Table
resource "aws_route_table" "vpc-ecs-public-route-table" {
  for_each = var.environments

  vpc_id = aws_vpc.vpc-ecs[each.key].id
}

# Resource-5: Crear Route en Route Table para acceso a internet
resource "aws_route" "vpc-ecs-public-route" {
  for_each = var.environments

  route_table_id = aws_route_table.vpc-ecs-public-route-table[each.key].id 
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.vpc-ecs-igw[each.key].id 
}

# Resource-6: Asociar Route Table con la Subnet
resource "aws_route_table_association" "vpc-ecs-public-route-table-associate" {
  for_each = var.environments

  route_table_id = aws_route_table.vpc-ecs-public-route-table[each.key].id 
  subnet_id = aws_subnet.vpc-ecs-public-subnet[each.key].id
}

# Resource-7: Crear Security Group
resource "aws_security_group" "ecs-vpc-sg" {
  for_each = var.environments

  name = "${each.key}-vpc-default-sg"
  vpc_id = aws_vpc.vpc-ecs[each.key].id
  description = "${each.key} VPC Default Security Group"

  ingress {
    description = "Allow Port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "ecs-${each.key}-security-group"
  }
}
