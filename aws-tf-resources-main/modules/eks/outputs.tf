locals {
  dualstack_oidc_issuer_url = try(replace(replace(module.eks.identity[0].oidc[0].issuer, "https://oidc.eks.", "https://oidc-eks."), ".amazonaws.com/", ".api.aws/"), null)
}

################################################################################
# Cluster
################################################################################

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = try(module.eks.arn, null)
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = try(module.eks.certificate_authority[0].data, null)
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = try(module.eks.endpoint, null)
}

output "cluster_id" {
  description = "The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts"
  value       = try(module.eks.cluster_id, "")
}

output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = try(module.eks.name, "")
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = try(module.eks.identity[0].oidc[0].issuer, null)
}

output "cluster_dualstack_oidc_issuer_url" {
  description = "Dual-stack compatible URL on the EKS cluster for the OpenID Connect identity provider"
  value       = local.dualstack_oidc_issuer_url
}

output "cluster_version" {
  description = "The Kubernetes version for the cluster"
  value       = try(module.eks.version, null)
}

output "cluster_platform_version" {
  description = "Platform version for the cluster"
  value       = try(module.eks.platform_version, null)
}

output "cluster_status" {
  description = "Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED`"
  value       = try(module.eks.status, null)
}

output "cluster_primary_security_group_id" {
  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console"
  value       = try(module.eks.vpc_config[0].cluster_security_group_id, null)
}

################################################################################
# IRSA
################################################################################

output "oidc_provider" {
  description = "The OpenID Connect identity provider (issuer URL without leading `https://`)"
  value       = try(replace(module.eks.identity[0].oidc[0].issuer, "https://", ""), null)
}

