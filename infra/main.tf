module "networking" {
  source       = "./modules/networking"
  project_name = var.project_name
  environment  = var.environment
}

module "security_groups" {
  source       = "./modules/security_groups"
  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.networking.vpc_id
}

module "alb" {
  source              = "./modules/alb"
  project_name        = var.project_name
  environment         = var.environment
  alb_sg_id           = module.security_groups.alb_sg_id
  public_subnets      = module.networking.public_subnet_ids
  vpc_id              = module.networking.vpc_id
  acm_certificate_arn = module.acm.app_certificate_arn
}

module "cloudwatch" {
  source       = "./modules/cloudwatch"
  project_name = var.project_name
  environment  = var.environment
}

module "rds" {
  source             = "./modules/rds"
  project_name       = var.project_name
  environment        = var.environment
  engine             = var.engine
  engine_version     = var.engine_version
  instance           = var.instance
  storage_size       = var.storage_size
  storage_type       = var.storage_type
  private_subnet_ids = module.networking.private_subnet_ids
  rds_sg_id          = module.security_groups.rds_sg_id
}

module "iam" {
  source        = "./modules/iam"
  project_name  = var.project_name
  environment   = var.environment
  db_secret_arn = module.rds.master_user_secret_arn
}

module "ecs" {
  source                    = "./modules/ecs"
  project_name              = var.project_name
  environment               = var.environment
  aws_region                = var.aws_region
  ecs_sg_id                 = module.security_groups.ecs_sg_id
  private_subnet_ids        = module.networking.private_subnet_ids
  container_name            = local.container_name
  container_image           = var.container_image
  alb_target_group_arn      = module.alb.target_group_arn
  task_role_arn             = module.iam.ecs_task_role_arn
  execution_role_arn        = module.iam.execution_role_arn
  cloudwatch_log_group_name = module.cloudwatch.log_group_name
  cpu                       = var.cpu
  memory                    = var.memory
  container_port            = var.container_port
  number_of_tasks           = var.number_of_tasks
  db_secret_arn             = module.rds.master_user_secret_arn
  db_host                   = module.rds.address
  db_port                   = module.rds.port
  db_name                   = module.rds.db_name
}

module "acm" {
  source                  = "./modules/acm"
  project_name            = var.project_name
  environment             = var.environment
  subdomain_name          = var.subdomain_name
  domain_name             = var.domain_name
  alb_zone_id             = module.alb.alb_zone_id
  alb_dns_name            = module.alb.alb_dns_name
  validation_record_fqdns = module.dns.cert_validation_fqdns
}

module "dns" {
  source                    = "./modules/dns"
  project_name              = var.project_name
  environment               = var.environment
  domain_name               = var.domain_name
  subdomain_name            = var.subdomain_name
  alb_dns_name              = module.alb.alb_dns_name
  alb_zone_id               = module.alb.alb_zone_id
  domain_validation_options = module.acm.domain_validation_options
}
