# variables.tf
# -----------------------------

variable "cluster_name" {
  type    = string
  default = "EKS-1"
}

variable "kubernetes_version" {
  type    = string
  default = "1.31"
}
