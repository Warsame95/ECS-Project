module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  vpc_id = var.vpc_id
  az = var.az
  igw-id = var.igw-id
}