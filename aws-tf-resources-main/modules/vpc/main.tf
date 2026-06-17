################################################################################
# VPC Module
################################################################################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.name
  cidr = var.vpc_cidr

  azs                        = var.azs
  private_subnets            = var.private_subnets
  public_subnets             = var.public_subnets
  intra_subnets              = var.intra_subnets
  database_subnets           = var.db_subnets
  database_subnet_group_name = var.database_subnet_group_name


  enable_dns_hostnames = true
  enable_nat_gateway   = true
  enable_vpn_gateway   = true
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    # Tags subnets for Karpenter auto-discovery
    "karpenter.sh/discovery" = var.name
  }

  tags = var.tags
}