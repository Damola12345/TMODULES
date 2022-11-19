# Configured AWS Provider with Proper Credentials
# terraform aws provider
provider "aws" {
  region  = var.region
  profile = "terraform-user"
}

# Create vpc
module "vpc" {
  source                       = "../modules/vpc"
  region                       = var.region
  project_name                 = var.project_name
  vpc-cidr                     = var.vpc-cidr
  public_subnet_1az_cidr       = var.public_subnet_1az_cidr
  public_subnet_2az_cidr       = var.public_subnet_2az_cidr
  private_app_subnet_1az_cidr  = var.private_app_subnet_1az_cidr
  private_app_subnet_2az_cidr  = var.private_app_subnet_2az_cidr
  private_data_subnet_1az_cidr = var.private_data_subnet_1az_cidr
  private_data_subnet_2az_cidr = var.private_data_subnet_2az_cidr

}

# Create nat gateways
module "nat_gateway" {
  source                     = "../modules/nat-gateway"
  vpc-id                     = module.vpc.vpc-id
  internet_gateway           = module.vpc.internet_gateway
  public_subnet_1az_id       = module.vpc.public_subnet_1az_id
  public_subnet_2az_id       = module.vpc.public_subnet_2az_id
  private_app_subnet_1az_id  = module.vpc.private_app_subnet_1az_id
  private_app_subnet_2az_id  = module.vpc.private_app_subnet_2az_id
  private_data_subnet_1az_id = module.vpc.private_data_subnet_1az_id
  private_data_subnet_2az_id = module.vpc.private_data_subnet_2az_id

}

# Create Security Groups
module "security_groups" {
  source = "../modules/security-groups"
  vpc-id = module.vpc.vpc-id

}
