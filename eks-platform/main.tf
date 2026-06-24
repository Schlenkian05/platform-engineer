module "vpc" {
  source = "./modules/vpc"

  vpc_cidr        = "10.0.0.0/16"
  public_subnet_a = "10.0.1.0/24"
  public_subnet_b = "10.0.2.0/24"

  private_subnet_a = "10.0.11.0/24"
  private_subnet_b = "10.0.12.0/24"
}

module "nat_gateway" {
  source = "./modules/nat-gateway"

  public_subnet_id       = module.vpc.public_subnet_ids[0]
  private_route_table_id = module.vpc.private_route_table_id
}

module "iam" {
  source = "./modules/iam"

  cluster_role_name = "cockroach-eks-cluster-role"
  node_role_name    = "cockroach-eks-node-role"
}

module "eks" {
  source = "./modules/eks"

  cluster_name = "platform-cockroach"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids

  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
}
