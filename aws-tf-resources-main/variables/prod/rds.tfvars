region = "me-central-1"
env    = "prod"

# Common ingress rules for all database instances
ingress_with_cidr_blocks = [
  {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    description = "PostgreSQL access from within VPC"
    cidr_blocks = "0.0.0.0/0"
  },
]

# Multiple database instances configuration
db_instances = {
  myapp = {
    identifier              = "MY-prod-MYAPP"
    engine_version          = "14"
    family                  = "postgres14"
    major_engine_version    = "14"
    instance_class          = "db.t4g.medium"
    allocated_storage       = "20"
    db_name                 = "MYAPPUSERNAME"
    master_username         = "MY_master_user"
    multi_az                = false
    publicly_accessible     = false
    db_subnet_group_name    = "database-prod"
    backup_retention_period = 0
    deletion_protection     = true
    tags = {
      owner       = "dev"
      cost-center = "dev"
      terraform   = "true"
      env         = "prod"
      role        = "myrole"
    }
  },
  my_backend = {
    identifier              = "my-prod-my-backend-01"
    engine_version          = "14"
    family                  = "postgres14"
    major_engine_version    = "14"
    instance_class          = "db.t4g.medium"
    allocated_storage       = "20"
    db_name                 = "my_backend"
    master_username         = "my_master_user"
    multi_az                = false
    publicly_accessible     = false
    db_subnet_group_name    = "database-prod"
    backup_retention_period = 0
    deletion_protection     = true
    tags = {
      owner       = "dev"
      cost-center = "dev"
      terraform   = "true"
      env         = "prod"
      role        = "my_backend"
    }
  }
}