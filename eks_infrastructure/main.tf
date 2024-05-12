module "org_vpc" {
  source = "./vpc"
  env    = var.env
  # cluster_name is needed for EKS to work, can be omitted if not using EKS
  cluster_name   = "${var.cluster_name}-${var.env}"
  vpc_name       = "EKS-Simple-Cluster-VPC"
  vpc_cidr_block = "10.0.0.0/16"
  azs_list       = ["us-east-1a", "us-east-1b"]
  region         = var.infrastructure_region
}

module "eks" {
  source                = "./eks"
  env                   = var.env
  infrastructure_region = var.infrastructure_region
  cluster_version       = var.cluster_version
  cluster_name          = "${var.cluster_name}-${var.env}"
  subnets_id_list = concat(
    [module.org_vpc.public_subnets[0].id, module.org_vpc.public_subnets[1].id],
    [module.org_vpc.private_subnets[0].id, module.org_vpc.private_subnets[1].id]
  )
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
}

module "dev_apps_nodegroup" {
  source                    = "./eks_nodegroup"
  env                       = var.env
  cluster_name              = module.eks.eks_cluster_name
  eks_cluster_arn           = module.eks.eks_cluster_arn
  node_group_name           = var.org_dev_apps_nodegroup_name
  node_group_version        = var.cluster_version_dev
  node_group_subnets        = [module.org_vpc.private_subnets[0].id, module.org_vpc.private_subnets[1].id]
  node_group_desired_size   = var.org_dev_apps_node_group_desired_size
  node_group_min_size       = var.org_dev_apps_node_group_min_size
  node_group_max_size       = var.org_dev_apps_node_group_max_size
  node_group_ami_type       = var.org_dev_apps_node_group_ami_type
  node_group_capacity_type  = var.org_dev_apps_node_group_capacity_type
  node_group_disk_size      = var.org_dev_apps_node_group_disk_size
  node_group_instance_types = var.org_dev_apps_node_group_instance_types
  node_group_role           = var.org_dev_apps_node_group_role
  taint_key                 = var.org_dev_apps_taint_key
  taint_value               = var.org_dev_apps_taint_value
  taint_effect              = var.org_dev_apps_taint_effect
  use_taint                 = var.org_dev_apps_use_taint
}



module "eks_addons" {
  source                              = "./addons"
  env                                 = var.env
  cluster_name                        = var.cluster_name
  addon_depends_on_nodegroup_no_taint = module.dev_apps_nodegroup.node_group_without_taint_arn
  eks_alb_role_arn                    = module.eks.eks_alb_role_arn
}

######################
# SG
######################

resource "aws_security_group" "alb_sg" {
  name        = "web-security-group-${var.env}"
  description = "Security group for HTTP and HTTPS traffic"

  vpc_id = module.org_vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from anywhere
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # All traffic
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic to anywhere
  }
}


######################
# ECR
######################


#######created from ansible

# module "country_ecr" {
#   source = "./ecr"
#   env    = lower(var.env)
#   name   = "paymob-repo"
# }
