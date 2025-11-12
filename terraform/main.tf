module "vpc" {
    source = "./modules/vpc"

vpc_name = "threat-vpc"
vpc_cidr =  "10.0.0.0/16"

public_subnets =  ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
 availability_zones = ["eu-west-2a", "eu-west-2b"]
enable_nat_gateway = true 
 tags = {
    Environment = "dev"
    Project     = "ThreatComposer"
  }
}

module "alb_sg" {
  source = "./modules/security"

  name        = "alb-sg"
  #description = "Allow HTTP & HTTPS from internet"
  vpc_id      = module.vpc.vpc_id
  ingress_rules = [
    { protocol = "tcp", from_port = 80, to_port = 80, cidr_blocks = ["0.0.0.0/0"] },
    { protocol = "tcp", from_port = 443, to_port = 443, cidr_blocks = ["0.0.0.0/0"] }
  ]
}


module "ecs_sg" {
    source = "./modules/security"
    #description = "Allow traffic from ALB only"
    name = "ecs-sg"
    vpc_id = module.vpc.vpc_id
    ingress_rules = [{ protocol = "tcp", from_port = 8081, to_port = 8081, security_groups = [module.alb_sg.sg_id]}]

  
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
resource "aws_route53_record" "app_alias" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "${var.sub_domain_name}.${var.domain_name}"

  type    = "A"

  alias {
    name                   = module.alb.alb_dns
    zone_id                = module.alb.alb_zone_id
    evaluate_target_health = false
  }
}

module "iam" {
  source = "./modules/iam"
  
}


module "aws_cloudwatch_log_group" {
  source = "./modules/logs"
  
}