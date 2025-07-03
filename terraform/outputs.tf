# outputs.tf
# -----------------------------

output "cluster_endpoint" {
  value = aws_eks_cluster.k8s-acc.endpoint
}

output "cluster_ca" {
  value = aws_eks_cluster.k8s-acc.certificate_authority[0].data
}

output "cluster_name" {
  value = aws_eks_cluster.k8s-acc.name
}
