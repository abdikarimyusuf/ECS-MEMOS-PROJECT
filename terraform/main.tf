module "vpc" {
    source = "./modules/vpc"

cidr =  "10.0.0.0/16"

public_subnets =  ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
db_subnets = ["10.0.5.0/24","10.0.6.0/24"]
 availability_zones = ["eu-west-2a", "eu-west-2b"]
enable_nat_gateway = true 

name_prefix = "memos"
}

module "alb_sg" {
  source = "./modules/security"

  name        = "alb-sg"

  vpc_id      = module.vpc.vpc_id
  ingress_rules = [
    { protocol = "tcp", from_port = 80, to_port = 80, cidr_blocks = ["0.0.0.0/0"] },
    { protocol = "tcp", from_port = 443, to_port = 443, cidr_blocks = ["0.0.0.0/0"] }
  ]
}


module "ecs_sg" {
    source = "./modules/security"

    name = "ecs-sg"
    vpc_id = module.vpc.vpc_id
    ingress_rules = [{ protocol = "tcp", from_port = 8081, to_port = 8081, security_groups = [module.alb_sg.sg_id]}]

  
}

module "rds_sg" {
  source = "./modules/security"

  name = "rds-sg"
  vpc_id = module.vpc.vpc_id
  ingress_rules = [{ protocol = "tcp", from_port = 5432, to_port = 5432, security_groups = [module.ecs_sg.sg_id]}]
}


module "ecs-cluster" {
    source = "./modules/ecs"
    cluster_name = "threat-composer-cluster"
    vpc_id = module.vpc.vpc_id
    security_group_id = module.ecs_sg.sg_id
}

module "ecr" {
    source = "./modules/ecr"

    repository_name = "threat-composer-ecr"

}


module "ecs_task" {
    source = "./modules/ecs_task"
    family = "threat-composer-task"
    cpu = "512"
    memory = "1024"
    execution_role_arn = module.iam.ecs_execution_role_arn
    task_role_arn = module.iam.ecs_task_role_arn
    container_port = 8081
    region = var.region
    image_url = var.image_url1
    database_secret_arn = module.database.secret_arn

 
    
  
}
module "alb" {
  source          = "./modules/alb"
  name            = "threat-composer-alb"
  subnets         = module.vpc.public_subnet_ids
  security_groups = [module.alb_sg.sg_id]
  vpc_id          = module.vpc.vpc_id
  port            = 443
  tags = {
    Environment = "dev"
    Project     = "ThreatComposer"
  }
   certificate_arn = module.acm.certificate_arn
    target_group_arn =module.alb.target_group_arn
}



module "ecs_service" {
    source = "./modules/ecs_service"
    name = "threat-composer-alb"
    cluster_arn = module.ecs-cluster.ecs_cluster_arn
   task_definition_arn = module.ecs_task.task_definition_arn
    desired_count = 2
    subnets = module.vpc.private_subnet_ids
    security_groups = [module.ecs_sg.sg_id]
    target_group_arn = module.alb.target_group_arn
    container_name = "threat-composer"
    container_port =8081
}

module "acm" {
    source      = "./modules/acm"
    domain_name = "app.abdikarim.co.uk"   # wildcard covers all subdomains
    zone_id     = var.route53_zone_id
}

module "database" {
  source = "./modules/rds"
   name_prefix = "memos-db"

   engine = "postgres"
   engine_version = "15"
   instance_class = "db.t3.micro"
   db_name = "memos"
   db_username = "memos"

   subnet_ids = module.vpc.db_subnet_ids
   security_group_ids = [module.rds_sg.sg_id]

   multi_az = false
   backup_retention = 1

   secret_name = "memos-db-cre-v4"

   tags = {
    app = "memos"
   }
   





  
}


module "R53" {
    source = "./modules/route53"
    subdomain = var.sub_domain_name
    zone_id = var.route53_zone_id
    alb_dns = module.alb.alb_dns
    alb_zone_id = module.alb.alb_zone_id
  
}
data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}
#
module "iam" {
  source = "./modules/iam"

  cluster_name = "memos"
  db_secret_arn = module.database.secret_arn
}
  



module "aws_cloudwatch_log_group" {
  source = "./modules/logs"
  
}
