resource "aws_iam_role" "eks_nodes_role" {
  name = "${var.cluster_name}-${var.node_group_name}-NODEGROUP-ROLE"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
  policy_arn = aws_iam_policy.cluster_autoScaler_policy.arn
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_policy" "cluster_autoScaler_policy" {
  name   = "${var.cluster_name}-${var.node_group_name}-CLUSTERAUTOSCALER-POLICY"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup"
            ],
            "Resource": "*"
        }
    ]
}
POLICY
}




resource "aws_iam_role_policy_attachment" "secret_manager_policy_for_eks_nodes" {
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  role       = aws_iam_role.eks_nodes_role.name
}

resource "aws_iam_role_policy_attachment" "cloudfront_policy_for_eks_nodes" {
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
  role       = aws_iam_role.eks_nodes_role.name
}

 resource "aws_iam_role_policy_attachment" "s3_policy" {
   policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
   role       = aws_iam_role.eks_nodes_role.name
}

# resource "aws_iam_role_policy_attachment" "sqs_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
#   role       = aws_iam_role.eks_nodes_role.name
# }

# resource "aws_iam_role_policy_attachment" "lambda_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
#   role       = aws_iam_role.eks_nodes_role.name
# }

