region = "me-central-1"
env    = "qa"
######################### IRSA ######################################
eks_oidc = "arn:aws:iam::893489348934348:oidc-provider/oidc.eks.me-central-1.amazonaws.com/id/A0D150E7FFA09A20989fdhnfjs"
oidc_issuer = "oidc.eks.me-central-1.amazonaws.com/id/893489348934348***************"
cluster_name = "mycluster-qa"
service_accounts = [
    {
      namespace = "mynamespace"
      name      = "mynamespace-sa"
      policy_statements = [
        {
          actions   = ["secretsmanager:GetSecretValue", "secretsmanager:DescribeSecret"]
          resources = ["*"]
          effect    = "Allow"
        },
        {
          actions   = ["s3:GetObject", "s3:ListBucket", "s3:PutObject"]
          resources = ["*"]
          effect    = "Allow"
        },
        {
          actions   = ["ses:GetSendQuota", "ses:SendEmail", "ses:SendRawEmail"]
          resources = ["*"]
          effect    = "Allow"
        }
      ]
    }
  ]
