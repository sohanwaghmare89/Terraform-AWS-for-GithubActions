region = "me-central-1"
env    = "prod"
######################### EC2 ######################################
name = "prod-pritunl-01"
tags = {
    owner       = "dev"
    cost-center = "dev"
    terraform   = "true"
    env         = "prod"
}

instance_type = "t3.medium"