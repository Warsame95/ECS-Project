module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  az       = var.az
}

module "ecs" {
  source             = "./modules/ecs"
  vpc_id             = module.vpc.vpc_id
  alb_sg_id          = module.alb.alb_sg_id
  region             = var.region
  name               = var.name
  private_subnet_ids = module.vpc.private_subnet_ids
  target_group_arn   = module.alb.target_group_arn
  db_username        = var.db_username
  db_password        = var.db_password
  db_host            = var.db_host
  db_name            = var.db_name
  execution_role_arn = module.iam.execution_role_arn
}

module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.vpc.vpc_id
  ecs_sg_id           = module.ecs.ecs_sg_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  acm_certificate_arn = module.dns.acm_certificate_arn
}

module "dns" {
  source   = "./modules/dns"
  dns_name = module.alb.dns_name
  zone_id  = module.alb.zone_id
}

module "rds" {
  source             = "./modules/rds"
  vpc_id             = module.vpc.vpc_id
  ecs_sg_id          = module.ecs.ecs_sg_id
  my_ip              = var.my_ip
  db_identifier      = var.db_identifier
  db_instance_class  = var.db_instance_class
  db_snapshot_id     = var.db_snapshot_id
  db_subnet_group    = var.db_subnet_group
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
}

module "iam" {
  source               = "./modules/iam"
  execution_role_name  = var.execution_role_name
  execution_policy_arn = var.execution_policy_arn
  my_secret_arn        = module.ecs.my_secret_arn
  kms_key_arn          = module.ecs.kms_key_arn
}
