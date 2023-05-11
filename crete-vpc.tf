# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

provider "aws" {
  region = var.region
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  name = "${var.name_prefix}-vpc" 
  
  cidr = "10.0.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  one_nat_gateway_per_az = false
#  enable_vpn_gateway = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }

#  tags = {
#    Terraform = "true"
#    Environment = "dev"
#  }
}

output "vpc_name" {
  value = module.vpc.name
}