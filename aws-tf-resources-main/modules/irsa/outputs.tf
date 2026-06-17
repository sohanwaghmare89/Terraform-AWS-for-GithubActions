output "irsa_roles" {
  description = "Map of IRSA IAM Role ARNs keyed by namespace-serviceaccount"
  value = {
    for key, role in aws_iam_role.irsa_roles :
    key => {
      role_name          = role.name
      role_arn           = role.arn
      assume_role_policy = role.assume_role_policy
    }
  }
}

output "irsa_policies" {
  description = "Map of IAM Policy ARNs attached to IRSA roles"
  value = {
    for key, policy in aws_iam_policy.irsa_policies :
    key => {
      policy_name     = policy.name
      policy_arn      = policy.arn
      policy_document = policy.policy
    }
  }
}
