variable "name" {}
variable "subnets" { type = list(string) }
variable "security_groups" { type = list(string) }
variable "vpc_id" {}
variable "port" { default = 8080 }
variable "tags" { type = map(string) }
variable "certificate_arn" {
  type        = string
}
variable "target_group_arn" {
    type        = string
  
}