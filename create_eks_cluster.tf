// Read the docs: https://registry.terraform.io/providers/vmware/tanzu-mission-control/latest/docs/guides/tanzu-mission-control_ekscluster

resource "tanzu-mission-control_ekscluster" "educates_eks_cluster" {
  depends_on = [
    module.vpc
  ]

  credential_name = var.credential_name        // Required
  region          = var.region                 // Required
# Above values come from the provider configuration

  name            = local.cluster_name     // Required. Name of this cluster

  ready_wait_timeout = "30m" // Wait time for cluster operations to finish (default: 30m).

  meta {
    description = "eks test cluster provisioned by terraform"
    labels      = { "provider" : "terraform" }
  }

  spec {
    cluster_group = var.cluster_group // Default: default

    config {
      role_arn           = local.controlplane_eks_role_arn // Required, forces new
      kubernetes_version = var.kubernetes_version     // Required
      tags               = { "mode" : "terraform" }

#      kubernetes_network_config {
#        service_cidr = "10.100.0.0/16"                   // Forces new
#      }

      logging {
        api_server         = true
        audit              = false
        authenticator      = true
        controller_manager = false
        scheduler          = false
      }

      vpc { // Required
        enable_private_access = true
        enable_public_access  = true
        public_access_cidrs = [ "0.0.0.0/0" ]
#        security_groups = [ // Forces new
#          "sg-0694eab810331b176",
#        ]
        subnet_ids = module.vpc.private_subnets
      }
    }

    nodepool {
      info {
        name        = "${var.name_prefix}-nodepool" // Required
        description = "description of node pool"
      }

      spec {
        // Refer to nodepool's schema
        role_arn       = local.node_eks_role_arn     // Required
        ami_type       = "AL2_x86_64"
        capacity_type  = "ON_DEMAND"
        root_disk_size = 20                          // In GiB, default: 20GiB
        tags           = { "nptag" : "npvalue" }
        node_labels    = { "npnodelabelkey" : "npnodelabelvalue" }

        subnet_ids = module.vpc.private_subnets

#        remote_access {
#          ssh_key = "cndev" // Required (if remote access is specified)
#
#          security_groups = [
#            "sg-0694eab810331b176",
#          ]
#        }

        scaling_config {
          desired_size = var.desired_nodes
          max_size     = var.max_nodes
          min_size     = var.min_nodes
        }

        update_config {
          max_unavailable_nodes = "2"
        }

        instance_types = [
          "c6i.xlarge",
#          "t3.medium",
#          "m3.large"
        ]

      }
    }
  }
}

output "eks_cluster_name" {
   value = tanzu-mission-control_ekscluster.educates_eks_cluster.name
}