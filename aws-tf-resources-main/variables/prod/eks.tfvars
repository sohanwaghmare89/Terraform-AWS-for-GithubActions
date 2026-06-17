region = "me-central-1"
env    = "prod"
######################### EKS ######################################
cluster_name    = "my-prod"
cluster_version = "1.32"

eks_managed_node_groups = {
  spot_nodes = {
    ami_type       = "BOTTLEROCKET_x86_64"
    instance_types = ["t3.large", "t3.xlarge", "t3.2xlarge", "t3.medium"]
    capacity_type  = "SPOT"
    min_size       = 1
    max_size       = 8
    desired_size   = 1

    labels = {
      "type" = "spot"
    }

    taints = []

    update_config = {
      max_unavailable = 1
    }
  }

  monitoring = {
    capacity_type = "SPOT"

    instance_types = [
      "t3.large",
      "t3.xlarge",
      "t3.2xlarge"
    ]

    min_size     = 1
    max_size     = 3
    desired_size = 1

    labels = {
      role = "monitoring"
    }

    taints = [
      {
        key    = "dedicated"
        value  = "monitoring"
        effect = "NO_SCHEDULE"
      }
    ]

    update_config = {
      max_unavailable = 1
    }
  }
}

tags = {
  owner       = "devops"
  cost-center = "shared"
  terraform   = "true"
  env         = "prod"
  "k8s.io/cluster-autoscaler/enabled"   = "true"
  "k8s.io/cluster-autoscaler/my-prod"   = "owned"
  "kubernetes.io/cluster/my-prod"       = "owned"
}





default-src 'self'; connect-src 'self' https://*.xyz.ai https://myblob.blob.core.windows.net; img-src 'self' data: blob: https://myblob.blob.core.windows.net; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; font-src 'self' data:; frame-src 'self'; object-src 'none'; base-uri 'self'; form-action 'self'; worker-src 'self' blob:;