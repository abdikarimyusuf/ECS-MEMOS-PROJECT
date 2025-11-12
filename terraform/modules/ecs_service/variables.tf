variable "name" {}
variable "cluster_arn" {}
variable "task_definition_arn" {}
variable "desired_count" { default = 1 }
variable "subnets" { type = list(string) }
variable "security_groups" { type = list(string) }
variable "target_group_arn" {}
variable "container_name" {}
variable "container_port" {}

