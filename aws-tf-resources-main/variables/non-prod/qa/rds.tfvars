region  = "me-central-1"
env     = "qa"
vpc_env = "non-prod"

ingress_with_cidr_blocks = [
  {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    description = "PostgreSQL access (controlled access)"
    cidr_blocks = "0.0.0.0/0"
  },
]

# extra_ingress_cidr_blocks = ["172.16.0.0/16"]

# QA database instance
db_instances = {
  primary = {
    identifier           = "mydb-qa-db-01"

    engine_version       = "16"
    family               = "postgres16"
    major_engine_version = "16"

    instance_class    = "db.t4g.small"   # burstable, cheapest
    allocated_storage = "50"             # 50 GB

    db_name             = "mydb"
    master_username     = "mydb_master"
    multi_az            = false
    publicly_accessible = false

    db_subnet_group_name    = "database"
    backup_retention_period = 0
    deletion_protection     = true

    tags = {
      owner     = "dev"
      terraform = "true"
      env       = "qa"
      app       = "myapp"
      cost      = "low"
      role      = "primary"
    }
  }
}
