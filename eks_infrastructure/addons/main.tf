module "alb_ingress" {
  source                              = "./alb_ingress"
  eks_alb_role_arn                    = var.eks_alb_role_arn
  addon_depends_on_nodegroup_no_taint = var.addon_depends_on_nodegroup_no_taint
  cluster_name                        = "${var.cluster_name}-${var.env}"
}
