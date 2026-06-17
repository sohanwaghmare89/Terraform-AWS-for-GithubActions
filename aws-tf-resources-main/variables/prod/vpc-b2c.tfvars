region = "me-central-1"
env    = "myspecialapp-prod"

######################### VPC ######################################
name = "myspecialapp-prod-vpc"
vpc_cidr = "172.28.0.0/16"

azs = ["me-central-1a", "me-central-1b", "me-central-1c"]

public_subnets  = ["172.28.48.0/24", "172.28.49.0/24", "172.28.50.0/24"]
private_subnets = ["172.28.0.0/20", "172.28.16.0/20", "172.28.32.0/20"]
db_subnets      = ["172.28.52.0/24", "172.28.53.0/24", "172.28.54.0/24"]
intra_subnets   = ["172.28.56.0/24", "172.28.57.0/24", "172.28.58.0/24"]

database_subnet_group_name = "database-myapp-prod"

tags = {
  owner       = "devops"
  cost-center = "specialapp"
  terraform   = "true"
  env         = "myspecial-prod"
}
