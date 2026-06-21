output "cluster_role_arn" {
  description = "EKS Cluster Role ARN"
  value       = aws_iam_role.eks_cluster_role.arn
}

output "node_role_arn" {
  description = "EKS Node Group Role ARN"
  value       = aws_iam_role.eks_node_role.arn
}

output "cluster_role_name" {
  value = aws_iam_role.eks_cluster_role.name
}

output "node_role_name" {
  value = aws_iam_role.eks_node_role.name
}
