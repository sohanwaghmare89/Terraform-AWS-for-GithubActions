region = "me-central-1"
env    = "qa"
######################### ECR ######################################
repository_name = ["myapp-backend", "myapp-frontend"]
tags = {
    owner       = "devops"
    cost-center = "shared"
    terraform   = "true"
    env         = "qa"
}
