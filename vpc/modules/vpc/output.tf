############################################################
# Output for VPC                                           #
############################################################

# Region
output "region" {
  value = var.region
}

# VPC ID
output "vpc-id" {
  value = aws_vpc.vpc.id
}

# Public Subnet 1 ID
output "public_subnet_1az_id" {
  value = aws_subnet.public_subnet_1az.id
}

# Public Subnet 2 ID
output "public_subnet_2az_id" {
  value = aws_subnet.public_subnet_2az.id
}

# Private Subnet 1 ID
output "private_app_subnet_1az_id" {
  value = aws_subnet.private_app_subnet_1az.id
}

# Private Subnet 2 ID
output "private_app_subnet_2az_id" {
  value = aws_subnet.private_app_subnet_2az.id
}

# Private Subnet 3 ID
output "private_data_subnet_1az_id" {
  value = aws_subnet.private_data_subnet_1az.id
}

# Private Subnet 4 ID
output "private_data_subnet_2az_id" {
  value = aws_subnet.private_data_subnet_2az.id
}

# Internet Gateway
output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}