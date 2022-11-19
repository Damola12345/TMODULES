# Create VPC
# terraform aws create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Data source to get all availability_zone in region
data "aws_availability_zones" "availability_zones" {}

# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "public_subnet_1az" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_1az_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1azA"
  }
}

# Create Public Subnet 2
# terraform aws create subnet
resource "aws_subnet" "public_subnet_2az" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_2az_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 2azB"
  }
}

# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public_subnet_1az_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_1az.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate Public Subnet 2 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public_subnet_2az_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_2az.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create Private Subnet 1
# terraform aws create subnet
resource "aws_subnet" "private_app_subnet_1az" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_app_subnet_1az_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "Private App Subnet 1 | App Tier"
  }
}

# Create Private Subnet 2
# terraform aws create subnet
resource "aws_subnet" "private_app_subnet_2az" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_app_subnet_2az_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "Private App Subnet 2 | App Tier"
  }
}

# Create Private Subnet 3
# terraform aws create subnet
resource "aws_subnet" "private_data_subnet_1az" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_data_subnet_1az_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Data Subnet 1 | Database Tier"
  }
}

# Create Private Subnet 4
# terraform aws create subnet
resource "aws_subnet" "private_data_subnet_2az" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_data_subnet_2az_cidr
  availability_zone       = data.aws_availability_zones.availability_zones.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Data Subnet 2 | Database Tier"
  }
}
