variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the ECS cluster"
  type        = map(string)
  default     = {
    Environment = "dev"
    Project     = "ecs-project"
  }
}


variable "vpc_id" {
  description = "The ID of the VPC where the ECS cluster resources will be deployed"
  type        = string
}

variable "security_group_id" {
  description = "The security group ID associated with the ECS cluster"
  type        = string
}