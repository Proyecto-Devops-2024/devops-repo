# Resource Block
# Resource-1: Crear VPC
resource "aws_vpc" "vpc-ecs-dev" {
  cidr_block = "10.1.0.0/16"

  tags = {
    "Name" = "vpc-ecs-dev"
  }
}

# Resource-2: Crear Subnets
resource "aws_subnet" "vpc-ecs-dev-public-subnet-1" {
  vpc_id = aws_vpc.vpc-ecs-dev.id
  cidr_block = "10.1.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    "Name" = "subnet-ecs-dev"
  }
}


# Resource-3: Crear Internet Gateway
resource "aws_internet_gateway" "vpc-ecs-dev-igw" {
  vpc_id = aws_vpc.vpc-ecs-dev.id
}

# Resource-4: Crear Route Table
resource "aws_route_table" "vpc-ecs-dev-public-route-table" {
  vpc_id = aws_vpc.vpc-ecs-dev.id
}

# Resource-5: Crear Route en Route Table para acceso a internet
resource "aws_route" "vpc-dev-ecs-public-route" {
  route_table_id = aws_route_table.vpc-ecs-dev-public-route-table.id 
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.vpc-ecs-dev-igw.id 
}


# Resource-6: Asociar Route Table con la Subnet
resource "aws_route_table_association" "vpc-ecs-dev-public-route-table-associate" {
  route_table_id = aws_route_table.vpc-ecs-dev-public-route-table.id 
  subnet_id = aws_subnet.vpc-ecs-dev-public-subnet-1.id
}

# Resource-7: Crear Security Group
resource "aws_security_group" "dev-ecs-vpc-sg" {
  name = "dev-vpc-default-sg"
  vpc_id = aws_vpc.vpc-ecs-dev.id
  description = "Dev VPC Default Security Group"

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
    "Name" = "ecs-dev-security-group"
  }
}