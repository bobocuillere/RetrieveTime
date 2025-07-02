module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  project_name         = var.project_name
  tags                 = local.tags
}

module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  tags         = local.tags
}

module "s3_static_site" {
  source        = "./modules/s3-static-site"
  project_name  = var.project_name
  tags          = local.tags
  frontend_path = "${path.root}/src/frontend"
}

module "cloudfront" {
  source       = "./modules/cloudfront"
  project_name = var.project_name
  tags         = local.tags

  # S3 origin inputs
  s3_bucket_domain_name = module.s3_static_site.bucket_domain_name
  s3_bucket_id          = module.s3_static_site.bucket_id
  s3_bucket_arn         = module.s3_static_site.bucket_arn
  oac_id                = module.s3_static_site.oac_id

  # ALB origin input
  alb_dns_name = module.alb.alb_dns_name
}

module "alb" {
  source       = "./modules/alb"
  project_name = var.project_name
  tags         = local.tags

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
}

module "ecs_fargate" {
  source       = "./modules/ecs-fargate"
  project_name = var.project_name
  tags         = local.tags

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  task_sg_id       = module.alb.ecs_task_sg_id
  target_group_arn = module.alb.target_group_arn

  ecr_repository_url = module.ecr.repository_url
}

module "monitoring" {
  source       = "./modules/monitoring"
  project_name = var.project_name
  tags         = local.tags

  ecs_cluster_name   = module.ecs_fargate.cluster_id
  ecs_service_name   = module.ecs_fargate.service_name
  alb_full_name      = module.alb.alb_full_name 
  cf_distribution_id = module.cloudfront.distribution_id
}
