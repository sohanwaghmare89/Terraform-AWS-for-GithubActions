region = "me-central-1"
env    = "prod"
######################### VPC ######################################
name = "my-prod-vpc"
vpc_cidr = "172.24.0.0/16"
azs = ["me-central-1a", "me-central-1b", "me-central-1c"]
public_subnets = ["172.24.48.0/24", "172.24.49.0/24", "172.24.50.0/24"]
private_subnets = ["172.24.0.0/20", "172.24.16.0/20","172.24.32.0/20"]
db_subnets      = ["172.24.52.0/24", "172.24.53.0/24", "172.24.54.0/24"]
intra_subnets   = ["172.24.56.0/24", "172.24.57.0/24", "172.24.58.0/24"]
database_subnet_group_name = "database-prod"
tags = {
    owner       = "devops"
    cost-center = "shared"
    terraform   = "true"
    env         = "prod"
}
