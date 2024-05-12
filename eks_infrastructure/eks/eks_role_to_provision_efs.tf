resource "aws_iam_role" "efs_csi_driver_role" {
#   depends_on = [aws_iam_openid_connect_provider.oidc, aws_eks_node_group.node_groups]
  name = "${var.cluster_name}-EFS-ROLE"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_openid_connect_provider.oidc.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${aws_iam_openid_connect_provider.oidc.url}:sub": "system:serviceaccount:kube-system:efs-csi-controller-sa"
        }
      }
    }
  ]
}

POLICY
}

resource "aws_iam_policy" "efs_csi_driver_policy" {
  name   = "EKS-EFS-CSI-Driver-Policy-${var.cluster_name}-${var.env}"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:DescribeAccessPoints",
        "elasticfilesystem:DescribeFileSystems"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "elasticfilesystem:CreateAccessPoint"
      ],
      "Resource": "*",
      "Condition": {
        "StringLike": {
          "aws:RequestTag/efs.csi.aws.com/cluster": "true"
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": "elasticfilesystem:DeleteAccessPoint",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "aws:ResourceTag/efs.csi.aws.com/cluster": "true"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_efs_csi_driver_policy_attachment" {
  policy_arn = aws_iam_policy.efs_csi_driver_policy.arn
  role       = aws_iam_role.efs_csi_driver_role.name
}