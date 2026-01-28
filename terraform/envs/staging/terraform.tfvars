environment = "stage"
project     = "memos"
region      = "eu-west-2"

domain_name     = "abdikarim.co.uk"
sub_domain_name = "app"

# You can reuse CIDRs, but many teams use different ranges.
vpc_cidr = "10.1.0.0/16"
public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnets = ["10.1.3.0/24", "10.1.4.0/24"]
db_subnets      = ["10.1.5.0/24", "10.1.6.0/24"]
availability_zones = ["eu-west-2a", "eu-west-2b"]

frontend_image = "561041808710.dkr.ecr.eu-west-2.amazonaws.com/memos-frontend:v0.27.5"
backend_image  = "561041808710.dkr.ecr.eu-west-2.amazonaws.com/memos-backend:v0.25.3"

frontend_port = 80
backend_port  = 8081

ecs_desired_count = 1
db_backup_retention = 3
db_deletion_protection = true
