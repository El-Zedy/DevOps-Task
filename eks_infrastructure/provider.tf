terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.12.0"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}




provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
