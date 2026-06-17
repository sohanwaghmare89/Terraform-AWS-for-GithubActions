region = "me-central-1"
env    = "qa"
vpc_env = "non-prod"
######################### EKS ######################################
cluster_name = "mycluster-qa"
cluster_version = "1.32"
eks_managed_node_groups = {
    spot_nodes = {
     ami_type = "BOTTLEROCKET_x86_64"
      instance_types = ["t3.large", "t3.xlarge", "t3.2xlarge", "t3.medium"]
      capacity_type  = "SPOT"
      min_size       = 1
      max_size       = 12
      desired_size   = 3
      labels         = { 
        "type" = "spot",
        "karpenter.sh/controller" = "true"
      }
      taints = []
      update_config = {
        max_unavailable = 1
      }
    }
}

tags = {
    owner       = "devops"
    cost-center = "shared"
    terraform   = "true"
    env         = "qa"  
    "k8s.io/cluster-autoscaler/enabled" = "true"
    "k8s.io/cluster-autoscaler/mycluster-qa" = "owned"
    "kubernetes.io/cluster/mycluster-qa" = "owned"
}
