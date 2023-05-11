variable "endpoint" {
  description = "The Tanzu Mission Control service endpoint hostname"
  type = string
}

variable "vmw_cloud_api_token" {
  description = "The VMware Cloud Services API Token"
  type = string
}

variable "credential_name" {
  description = "Credential name to use in Tanzu Mission control to provision EKS clusters"
  type = string
}

variable "cluster_group" {
  description = "Cluster group to use for the EKS cluster in TMC"
  type = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "name_prefix" {
  description = "Prefix name for everything"
  type        = string
}

variable "kubernetes_version" {
  description = "Version of kubernetes cluster to create"
  type = string
  default = "1.24"
}

variable "desired_nodes" {
  description = "Initial number of nodes to provision from pool"
  type = string
  default = 2
}

variable "max_nodes" {
  description = "Maximum number of nodes the nodepool can grow to"
  type = string
  default = 6
}

variable "min_nodes" {
  description = "Minimum number of nodes the nodepool can shrink to"
  type = number
  default = 2
}

variable "instance_types" {
  description = "Instance types for the nodepool"
  type = list(string)
  default = ["c6i.xlarge",]
}