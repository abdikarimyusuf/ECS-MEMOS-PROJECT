environment = "prod"
project     = "memos"
region      = "eu-west-2"

domain_name     = "abdikarim.co.uk"
sub_domain_name = "app"

vpc_cidr = "10.2.0.0/16"
public_subnets  = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnets = ["10.2.3.0/24", "10.2.4.0/24"]
db_subnets      = ["10.2.5.0/24", "10.2.6.0/24"]
availability_zones = ["eu-west-2a", "eu-west-2b"]

frontend_image = "561041808710.dkr.ecr.eu-west-2.amazonaws.com/memos-frontend:v0.27.5"
backend_image  = "561041808710.dkr.ecr.eu-west-2.amazonaws.com/memos-backend:v0.25.3"

ecs_desired_count = 1
ecs_cpu    = "512"
ecs_memory = "1024"

db_instance_class = "db.t3.small"
db_multi_az = true
db_backup_retention = 7
db_deletion_protection = true
