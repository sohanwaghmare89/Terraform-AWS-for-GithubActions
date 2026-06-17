data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_iam_openid_connect_provider" "oidc" {
  arn = var.eks_oidc
}

locals {
  service_accounts_map = {
    for sa in var.service_accounts :
    "${sa.namespace}-${sa.name}" => sa
  }
}

resource "aws_iam_role" "irsa_roles" {
  for_each = local.service_accounts_map

  name = "${var.cluster_name}-${each.value.namespace}-${each.value.name}-irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = data.aws_iam_openid_connect_provider.oidc.arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${var.oidc_issuer}:aud" : "sts.amazonaws.com",
          "${var.oidc_issuer}:sub" = "system:serviceaccount:${each.value.namespace}:${each.value.name}"
        }
      }
    }]
  })
}


resource "aws_iam_policy" "irsa_policies" {
  for_each = local.service_accounts_map

  name        = "${var.env}-${each.value.name}-policy"
  description = "IAM policy for ${each.value.name} in ${each.value.namespace}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      for stmt in each.value.policy_statements : {
        Effect   = stmt.effect
        Action   = stmt.actions
        Resource = stmt.resources
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "attach_policies" {
  for_each = local.service_accounts_map

  role       = aws_iam_role.irsa_roles[each.key].name
  policy_arn = aws_iam_policy.irsa_policies[each.key].arn
}
