variable "env" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "cluster_name" {
  type    = string
  default = "EKS-CLUSTER"
}

variable "vpc_name" {
  type = string
}

variable "region" {
  type = string
}

variable "azs_list" {
  type = list(string)
}
