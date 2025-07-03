#eks.tf
resource "aws_eks_cluster" "k8s-acc" {
  name     = var.cluster_name
  version  = var.kubernetes_version
  role_arn = aws_iam_role.k8s-acc-cluster.arn

  vpc_config {
    subnet_ids = aws_subnet.k8s-acc[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.k8s-acc-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.k8s-acc-AmazonEKSVPCResourceController
  ]
}

resource "aws_eks_node_group" "k8s-acc" {
  cluster_name    = aws_eks_cluster.k8s-acc.name
  node_group_name = var.cluster_name
  node_role_arn   = aws_iam_role.k8s-acc-node.arn
  subnet_ids      = aws_subnet.k8s-acc[*].id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.k8s-acc-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.k8s-acc-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.k8s-acc-AmazonEC2ContainerRegistryReadOnly
  ]
}
