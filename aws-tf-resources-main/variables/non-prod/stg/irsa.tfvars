region = "me-central-1"
env    = "stg"
######################### IRSA ######################################
eks_oidc = "arn:aws:iam::893489348934348:oidc-provider/oidc.eks.me-central-1.amazonaws.com/id/32084LJHEF990DNF"
oidc_issuer = "oidc.eks.me-central-1.amazonaws.com/id/32B1809DSFDS98FDS0FD89SDFDS"
cluster_name = "mycluster-stg"
service_accounts = [
    {
      namespace = "mynamspace"
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