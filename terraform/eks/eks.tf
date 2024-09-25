
resource "aws_eks_cluster" "eks" {
  name                          = "${local.resource_name_prefix}-${local.resource_name_suffix}"
  role_arn                      = aws_iam_role.eks.arn
  bootstrap_self_managed_addons = true

  vpc_config {
    subnet_ids             = var.vpc_subnet_ids
    endpoint_public_access = true
    public_access_cidrs = [
      local.my_cidr_block
    ]
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  upgrade_policy {
    support_type = "STANDARD"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_amazon_eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_amazon_eks_vpc_resource_controller,
  ]
}

resource "aws_eks_access_entry" "dgimeno" {
  cluster_name  = aws_eks_cluster.eks.name
  principal_arn = data.aws_iam_user.dgimeno.arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "dgimeno" {
  depends_on    = [aws_eks_access_entry.dgimeno]
  cluster_name  = aws_eks_cluster.eks.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  principal_arn = data.aws_iam_user.dgimeno.arn

  access_scope {
    type = "cluster"
  }
}
