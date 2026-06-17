region = "me-central-1"
env    = "prod"
######################### IRSA ######################################
eks_oidc = "arn:aws:iam::893489348934348:oidc-provider/oidc.eks.me-central-1.amazonaws.com/id/90DF90DSF78F399CC08F389SF98S90FDS"
oidc_issuer = "oidc.eks.me-central-1.amazonaws.com/id/KJSDOPUNFLAJDSJF"
cluster_name = "mycluster-prod"
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
        }
      ]
    }
  ]