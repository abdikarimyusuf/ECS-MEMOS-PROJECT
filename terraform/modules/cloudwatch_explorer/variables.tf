variable "task_family" {
  description = "ECS task family name"
  type        = string
}

variable "image" {
  description = "Container image for CloudWatch Exporter"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 9106
}

variable "cpu" {
  description = "CPU units for the Fargate task"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "Memory for the Fargate task"
  type        = string
  default     = "512"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket where Prometheus config is stored"
  type        = string
}

variable "s3_key" {
  description = "S3 object key for Prometheus config"
  type        = string
}

variable "log_group" {
  description = "CloudWatch log group for container logs"
  type        = string
}

variable "ecs_cluster_id" {
  description = "ECS Cluster ID to run the service in"
  type        = string
}

variable "service_name" {
  description = "Name of ECS service"
  type        = string
}

variable "desired_count" {
  description = "Number of tasks to run"
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "List of subnet IDs for Fargate service"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for Fargate service"
  type        = list(string)
}
