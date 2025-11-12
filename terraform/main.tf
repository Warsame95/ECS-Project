module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  vpc_id = var.vpc_id
  az = var.az
  igw-id = var.igw-id
}

module "ecs" {
    source = "./modules/ecs"
     vpc_id = var.vpc_id
     alb_sg_id = module.alb.alb_sg_id
}

module "alb" {
  source = "./modules/alb"
  vpc_id = var.vpc_id
  ecs_sg_id = module.ecs.ecs_sg_id
  public_subnet_id = module.vpc.public_subnet_ids[0]
}

module "dns" {
  source = "./modules/dns"
  dns_name = module.alb.dns_name
  zone_id = module.alb.zone_id
}