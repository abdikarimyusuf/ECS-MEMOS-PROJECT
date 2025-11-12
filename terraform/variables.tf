
variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "eu-west-2"
}

variable "route53_zone_id" {
  type = string
}

variable "domain_name" {
  type = string
  
}

variable "sub_domain_name" {
  type = string
  
}

variable "image_url1" {
  type = string
  
}

