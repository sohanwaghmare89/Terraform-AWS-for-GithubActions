region  = "me-central-1"
env     = "stg"
vpc_env = "non-prod"

########################## EKS #########################

cluster_name    = "mycluster-stg"
cluster_version = "1.33"

eks_managed_node_groups = {
  spot_nodes = {
    ami_type       = "BOTTLEROCKET_x86_64"
    instance_types = ["t3.large", "t3.xlarge", "t3.2xlarge", "t3.medium"]
    capacity_type  = "SPOT"
    disk_size      = 50
    min_size       = 1
    max_size       = 18
    desired_size   = 8

    labels = {
      "type"                       = "spot"
      "karpenter.sh/controller"    = "true"
    }

    taints = []

    update_config = {
      max_unavailable = 1
    }
  },

  kafka_nodes = {
    ami_type       = "BOTTLEROCKET_x86_64"
    instance_types = ["t3.large", "t3.medium"]
    capacity_type  = "SPOT"
    disk_size      = 50
    min_size       = 1
    max_size       = 3
    desired_size   = 2

    labels = {
      "type"                       = "spot"
      "karpenter.sh/controller"    = "true"
      "kafka-node"                 = "true"
      "node-role"                  = "kafka"
    }

    taints = [
      {
        key    = "kafka"
        value  = "true"
        effect = "NO_SCHEDULE"
      }
    ]

    update_config = {
      max_unavailable = 1
    }
  },

  b2c_nodes = {
    ami_type       = "BOTTLEROCKET_x86_64"
    instance_types = ["t3.large", "t3.xlarge", "t3.2xlarge", "t3.medium", "c5d.large", "c5d.xlarge"]
    capacity_type  = "SPOT"
    disk_size      = 50
    min_size       = 1
    max_size       = 12
    desired_size   = 4

    labels = {
      "type"                       = "spot"
      "my-node"                   = "true"
      "node-role"                  = "b2c"
    }

    taints = [
      {
        key    = "my"
        value  = "true"
        effect = "NO_SCHEDULE"
      }
    ]

    update_config = {
      max_unavailable = 1
    }
  }
}

tags = {
  owner                                      = "devops"
  cost-center                                = "shared"
  terraform                                  = "true"
  env                                        = "stg"
  "k8s.io/cluster-autoscaler/enabled"         = "true"
  "k8s.io/cluster-autoscaler/mycluster-stg"        = "owned"
  "kubernetes.io/cluster/mycluster-stg"            = "owned"
}
