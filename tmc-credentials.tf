data "tanzu-mission-control_credential" "tmc_cred" {
  name = var.credential_name
}

locals {
   cloudformation_key = data.tanzu-mission-control_credential.tmc_cred.meta[0].annotations.GeneratedTemplateID
}

data "aws_iam_role" "controlplane_eks_role" {
  name = "control-plane.${local.cloudformation_key}.eks.tmc.cloud.vmware.com"
}

data "aws_iam_role" "node_eks_role" {
  name = "worker.${local.cloudformation_key}.eks.tmc.cloud.vmware.com"
}

locals {
   controlplane_eks_role_arn = data.aws_iam_role.controlplane_eks_role.arn
   node_eks_role_arn = data.aws_iam_role.node_eks_role.arn
}