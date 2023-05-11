terraform {
  required_providers {
    tanzu-mission-control = {
      source = "vmware/tanzu-mission-control"
      version = "1.1.7"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.66.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }

  required_version = "~> 1.4.6"
}

provider "tanzu-mission-control" {
  endpoint = var.endpoint
  vmw_cloud_api_token = var.vmw_cloud_api_token
}


