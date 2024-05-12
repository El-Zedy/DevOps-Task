
#####################################################
#   General
#####################################################

variable env {
    type = string
}

variable infrastructure_region {
  type = string
}


#####################################################
#  eks
#####################################################

variable cluster_name {
    type = string
}

variable cluster_version {
  type = string
}

variable endpoint_private_access {
  type = bool
}

variable endpoint_public_access {
  type = bool
}

#####################################################
#  eks_node_group
#####################################################

variable org_dev_apps_nodegroup_name {
  type = string
}

variable org_dev_apps_node_group_desired_size {
  type = number
}

variable org_dev_apps_node_group_min_size {
  type = number
}

variable org_dev_apps_node_group_max_size {
  type = number
}

variable org_dev_apps_node_group_ami_type {
  type = string
}

variable org_dev_apps_node_group_capacity_type {
  type = string
}

variable org_dev_apps_node_group_disk_size {
  type = number
}


variable org_dev_apps_node_group_instance_types {
  type = list
}

variable org_dev_apps_node_group_role {
  type = string
}

variable org_dev_apps_taint_key {
  type = string
}

variable org_dev_apps_taint_value {
  type = string
}

variable org_dev_apps_taint_effect {
  type = string
}

variable org_dev_apps_use_taint {
  type = bool
}

variable cluster_version_dev {
  type = string
}

