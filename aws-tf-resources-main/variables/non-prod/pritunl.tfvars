region = "me-central-1"
env    = "non-prod"
######################### EC2 ######################################
name = "non-prod-pritunl-01"
ami = "ami-0cfac8ef59a421fab"
tags = {
    owner       = "dev"
    cost-center = "dev"
    terraform   = "true"
    env         = "non-prod"
}

instance_type = "t3.medium"