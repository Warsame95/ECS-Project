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
     MEMOS_DSN = var.MEMOS_DSN
     region = var.region
     name = var.name
     container_image = var.container_image
     private_subnet_ids = module.vpc.private_subnet_ids
     target_group_arn = module.alb.target_group_arn
}

module "alb" {
  source = "./modules/alb"
  vpc_id = var.vpc_id
  ecs_sg_id = module.ecs.ecs_sg_id
  public_subnet_id = module.vpc.public_subnet_ids[0]
  acm_certificate_arn = module.dns.acm_certificate_arn
}

module "dns" {
  source = "./modules/dns"
  dns_name = module.alb.dns_name
  zone_id = module.alb.zone_id
}

module "rds" {
  source = "./modules/rds"
  vpc_id = var.vpc_id
  ecs_sg_id = module.ecs.ecs_sg_id
  my_ip = var.my_ip
  db_identifier = var.db_identifier
  db_instance_class = var.db_instance_class
  db_snapshot_id = var.db_snapshot_id
  db_subnet_group = var.db_subnet_group
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids = module.vpc.public_subnet_ids
}