region = "me-central-1"
env    = "non-prod"
######################### VPC ######################################
name = "MY-non-prod-vpc"
vpc_cidr = "172.16.0.0/16"
azs = ["me-central-1a", "me-central-1b", "me-central-1c"]
public_subnets = ["172.16.48.0/24", "172.16.49.0/24", "172.16.50.0/24"]
private_subnets = ["172.16.0.0/20", "172.16.16.0/20","172.16.32.0/20"]
db_subnets      = ["172.16.52.0/24", "172.16.53.0/24", "172.16.54.0/24"]
intra_subnets   = ["172.16.56.0/24", "172.16.57.0/24", "172.16.58.0/24"]
database_subnet_group_name = "database"
tags = {
    owner       = "devops"
    cost-center = "shared"
    terraform   = "true"
    env         = "non-prod"
}
