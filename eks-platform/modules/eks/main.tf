module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = var.cluster_name
  kubernetes_version = var.kubernetes_version

  enable_irsa = true
  enable_cluster_creator_admin_permissions = true

  endpoint_public_access  = true
  endpoint_private_access = true

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  create_iam_role = false
  iam_role_arn    = var.cluster_role_arn


 cluster_addons = {

    coredns = {}

    kube-proxy = {}

    vpc-cni = {}

    
  }

  eks_managed_node_groups = {

    general = {

      iam_role_arn = var.node_role_arn

      min_size     = var.min_size
      desired_size = var.desired_size
      max_size     = var.max_size

      instance_types = var.instance_types

      capacity_type = "ON_DEMAND"
    }
  }
}
