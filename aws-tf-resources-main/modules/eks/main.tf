data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "mytfbucket-tfstates"
    key    = "${var.vpc_env != null ? var.vpc_env : var.env}/vpc.tfstate"
    region = var.region
  }
}

################################################################################
# EKS Module
################################################################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  enable_irsa     = true

  # Disable cluster logging to match current state
  cluster_enabled_log_types = []

  # Gives Terraform identity admin access to cluster which will
  # allow deploying resources (Karpenter) into the cluster
  enable_cluster_creator_admin_permissions = true
  cluster_endpoint_public_access           = true

  # EKS Addons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
    aws-ebs-csi-driver     = {}
  }

  vpc_id                   = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids               = data.terraform_remote_state.network.outputs.private_subnets
  control_plane_subnet_ids = data.terraform_remote_state.network.outputs.intra_subnets

  eks_managed_node_groups = var.eks_managed_node_groups

  node_security_group_tags = merge(var.tags, {
    # NOTE - if creating multiple security groups with this module, only tag the
    # security group that Karpenter should utilize with the following tag
    # (i.e. - at most, only one security group should have this tag in your account)
    "karpenter.sh/discovery" = var.cluster_name
  })

  tags = merge({
    Name = "${var.cluster_name}"
    },
    var.tags
  )
}
