variable "region" {
  type    = string
  default = "me-central-1"
}

variable "env" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "eks_oidc" {
  type = string
}

variable "oidc_issuer" {
  type = string
}

variable "service_accounts" {
  description = "List of service accounts with namespace and IAM policy statements"
  type = list(object({
    namespace = string
    name      = string
    policy_statements = list(object({
      actions   = list(string)
      resources = list(string)
      effect    = string
    }))
  }))
}
