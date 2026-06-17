region = "me-central-1"
env    = "stg"
######################### ECR ######################################
repository_name = ["mytfbucket", "my-backend", "my-ui", "python-base", "project-bucket"]

tags = {
    owner       = "devops"
    cost-center = "shared"
    terraform   = "true"
    env         = "stg"
}
