# provider.tf
# -----------------------------

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.24.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# These data sources configure the Kubernetes provider once the EKS cluster is created
data "aws_eks_cluster" "k8s-acc" {
  name = aws_eks_cluster.k8s-acc.name
}

data "aws_eks_cluster_auth" "k8s-acc" {
  name = aws_eks_cluster.k8s-acc.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.k8s-acc.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.k8s-acc.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.k8s-acc.token
  # Do not add `depends_on` here; it's not allowed in provider block
}
