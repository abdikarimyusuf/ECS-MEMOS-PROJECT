environment = "dev"
project     = "memos"
region      = "eu-west-2"

domain_name     = "abdikarim.co.uk"
sub_domain_name = "app"
env = "dev"

vpc_cidr           = "10.0.0.0/16"
public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
db_subnets         = ["10.0.5.0/24", "10.0.6.0/24"]
availability_zones = ["eu-west-2a", "eu-west-2b"]
enable_nat_gateway = true

frontend_image = "561041808710.dkr.ecr.eu-west-2.amazonaws.com/memos-frontend:v0.27.5"
backend_image  = "561041808710.dkr.ecr.eu-west-2.amazonaws.com/memos-backend:v0.25.3"

frontend_port = 80
backend_port  = 8081

ecs_desired_count = 1
ecs_cpu           = "512"
ecs_memory        = "1024"

db_instance_class      = "db.t3.micro"
db_multi_az            = false
db_backup_retention    = 1
db_deletion_protection = false
