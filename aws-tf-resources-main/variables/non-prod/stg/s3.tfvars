region = "me-central-1"
env    = "stg"
######################### S3 ######################################

bucket_name = ["my-stg"]
tags = [{
    owner       = "dev"
    cost-center = "dev"
    terraform   = "true"
    env         = "stg"
}]