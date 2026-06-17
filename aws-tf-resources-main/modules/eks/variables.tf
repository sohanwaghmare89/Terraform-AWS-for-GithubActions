variable "region" {
  type    = string
  default = "me-central-1"
}

variable "env" {
  type = string
}

variable "vpc_env" {
  type        = string
  description = "Environment name for VPC state lookup"
  default     = null
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group configurations"

  type = map(object({
    ami_type       = optional(string)
    capacity_type  = optional(string)
    instance_types = list(string)

    min_size     = number
    max_size     = number
    desired_size = number

    labels = optional(map(string))

    taints = optional(list(object({
      key    = string
      value  = string
      effect = string
    })))

    update_config = optional(object({
      max_unavailable            = optional(number)
      max_unavailable_percentage = optional(number)
    }))

    tags = optional(map(string))
  }))
}
