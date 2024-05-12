resource "aws_eks_cluster" "eks_cluster" {
  name                      = var.cluster_name
  role_arn                  = aws_iam_role.eks_role.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  version                   = var.cluster_version
  encryption_config {
    provider {
      key_arn = aws_kms_key.enc_kms_key.arn
    }
    resources = ["secrets"]
  }

  vpc_config {
    subnet_ids              = var.subnets_id_list
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  provisioner "local-exec" {
    command = <<EOT
        aws eks --region ${var.infrastructure_region} update-kubeconfig --name ${var.cluster_name}
    EOT
  }
  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy]
}
