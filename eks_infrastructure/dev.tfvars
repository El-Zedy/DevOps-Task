# ------------------------------------------------------
#                       General                        #
# ------------------------------------------------------

env                   = "DEV"
infrastructure_region = "us-east-1"

# ------------------------------------------------------
#                       EKS Cluster                    #
# ------------------------------------------------------
cluster_name            = "EKS-Simple-Cluster"
cluster_version         = "1.29"
endpoint_private_access = false
endpoint_public_access  = true
# ------------------------------------------------------
#                       NODE GROUPS                    #
# ------------------------------------------------------

org_dev_apps_nodegroup_name            = "DEV-APPLICATIONS-NODEGROUP"
org_dev_apps_node_group_desired_size   = 1
org_dev_apps_node_group_min_size       = 1
org_dev_apps_node_group_max_size       = 1
org_dev_apps_node_group_ami_type       = "AL2_x86_64"
org_dev_apps_node_group_capacity_type  = "ON_DEMAND"
org_dev_apps_node_group_disk_size      = 50
org_dev_apps_node_group_instance_types = ["t3.medium"]
org_dev_apps_node_group_role           = "dev-applications"
org_dev_apps_use_taint                 = false
org_dev_apps_taint_key                 = ""
org_dev_apps_taint_value               = ""
org_dev_apps_taint_effect              = ""
cluster_version_dev                    = "1.29"
