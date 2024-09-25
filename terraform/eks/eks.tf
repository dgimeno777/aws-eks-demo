
resource "aws_eks_cluster" "example" {
  name     = "${local.resource_name_prefix}-${local.resource_name_suffix}"
  role_arn = aws_iam_role.eks.arn

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
