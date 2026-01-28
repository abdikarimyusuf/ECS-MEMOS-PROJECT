terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

}

terraform {
  backend "local" {
    path = "../../state/dev.tfstate"
  }
}

provider "aws" {
  region = var.region
}