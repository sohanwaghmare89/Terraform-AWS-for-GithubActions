data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "aura-tfstates"
    key    = "${var.vpc_env != null ? var.vpc_env : var.env}/vpc.tfstate"
    region = var.region
  }
}

################################################################################
# Local Values for Processing DB Instances
################################################################################

locals {
  # Support both single instance (legacy) and multiple instances (new)
  # Use "default" as key to maintain existing resource names
  db_instances = var.db_instances != null ? var.db_instances : {
    default = {
      identifier              = var.name
      engine_version          = var.engine_version
      family                  = var.family
      major_engine_version    = var.major_engine_version
      instance_class          = var.instance_class
      allocated_storage       = var.allocated_storage
      db_name                 = var.db_name
      master_username         = var.master_username
      multi_az                = var.multi_az
      publicly_accessible     = var.publicly_accessible
      db_subnet_group_name    = var.db_subnet_group_name
      backup_retention_period = var.backup_retention_period
      deletion_protection     = var.deletion_protection
      parameters              = var.db_parameters
      tags                    = var.tags
    }
  }
}

################################################################################
# RDS Modules - Multiple Instances
################################################################################

module "db" {
  source = "terraform-aws-modules/rds/aws"

  for_each = local.db_instances

  identifier = each.value.identifier

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine               = "postgres"
  engine_version       = each.value.engine_version
  family               = each.value.family
  major_engine_version = each.value.major_engine_version
  instance_class       = each.value.instance_class
  publicly_accessible  = each.value.publicly_accessible

  allocated_storage = each.value.allocated_storage

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  db_name  = each.value.db_name
  username = each.value.master_username
  port     = 5432

  multi_az               = each.value.multi_az
  db_subnet_group_name   = each.value.db_subnet_group_name
  vpc_security_group_ids = [module.security_group[each.key].security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period              = lookup(each.value, "backup_retention_period", 0)
  deletion_protection                  = lookup(each.value, "deletion_protection", true)
  manage_master_user_password_rotation = false

  parameters = lookup(each.value, "parameters", [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ])

  tags = merge(
    each.value.tags,
    {
      "DatabaseKey" = each.key
    }
  )
}

################################################################################
# Security Groups - Multiple Instances
################################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  for_each = local.db_instances

  name        = each.value.identifier
  description = "Complete PostgreSQL example security group"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress_with_cidr_blocks = concat(
    var.ingress_with_cidr_blocks,
    [
      {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        description = "PostgreSQL access from VPC"
        cidr_blocks = data.terraform_remote_state.network.outputs.vpc_cidr_block
      }
    ],
    length(var.extra_ingress_cidr_blocks) > 0 ? [
      {
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        description = "PostgreSQL access from App/VPN"
        cidr_blocks = join(",", var.extra_ingress_cidr_blocks)
      }
    ] : []
  )
}
