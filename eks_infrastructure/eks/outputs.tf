output eks_cluster_arn {
  value = aws_eks_cluster.eks_cluster.arn
}


output eks_cluster_name {
  value = aws_eks_cluster.eks_cluster.id
}

output eks_alb_role_arn {
  value = aws_iam_role.load_balancer_controller_role.arn
}

output eks_efs_role_arn {
  value = aws_iam_role.efs_csi_driver_role.arn
}
