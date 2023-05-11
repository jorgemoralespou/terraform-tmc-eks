resource "random_string" "suffix" {
  length  = 4
  special = false
  upper = false
}

locals {
  cluster_name = "${var.name_prefix}-eks-${random_string.suffix.result}"
}