variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "threat-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "enable_nat_gateway" {
  type        = bool
  description = "Whether to create a NAT Gateway for private subnets"
  default     = false
}


variable "tags" {
  description = "Optional tags for resources"
  type        = map(string)
  default     = {}
}

variable "availability_zones" {
   type = list(string)
    }