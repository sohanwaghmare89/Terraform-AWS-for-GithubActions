variable "region" {
  type    = string
  default = "me-central-1"
}

variable "env" {
  type = string
}

variable "vpc_env" {
  type        = string
  description = "Environment name for VPC state lookup"
  default     = null
}

################################################################################
# Legacy Variables (for backward compatibility)
################################################################################

variable "name" {
  type        = string
  description = "Legacy variable for single DB instance name"
  default     = null
}

variable "engine_version" {
  type        = string
  description = "Legacy variable for single DB instance engine version"
  default     = null
}

variable "family" {
  type        = string
  description = "Legacy variable for single DB instance family"
  default     = null
}

variable "major_engine_version" {
  type        = string
  description = "Legacy variable for single DB instance major engine version"
  default     = null
}

variable "instance_class" {
  type        = string
  description = "Legacy variable for single DB instance class"
  default     = null
}

variable "allocated_storage" {
  type        = string
  description = "Legacy variable for single DB instance allocated storage"
  default     = null
}

variable "db_name" {
  type        = string
  description = "Legacy variable for single DB instance database name"
  default     = null
}

variable "master_username" {
  type        = string
  description = "Legacy variable for single DB instance master username"
  default     = null
}

variable "multi_az" {
  type        = bool
  description = "Legacy variable for single DB instance multi-AZ"
  default     = null
}

variable "publicly_accessible" {
  type        = bool
  description = "Legacy variable for single DB instance public accessibility"
  default     = null
}

variable "db_subnet_group_name" {
  type        = string
  description = "Legacy variable for single DB instance subnet group name"
  default     = null
}

variable "backup_retention_period" {
  type        = number
  description = "Legacy variable for single DB instance backup retention period"
  default     = 0
}

variable "deletion_protection" {
  type        = bool
  description = "Legacy variable for single DB instance deletion protection"
  default     = true
}

variable "db_parameters" {
  type = list(object({
    name  = string
    value = string
  }))
  description = "Legacy variable for single DB instance parameters"
  default = [
    {
      name  = "autovacuum"
      value = "1"
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]
}

variable "tags" {
  type        = map(string)
  description = "Legacy variable for single DB instance tags"
  default     = {}
}

variable "ingress_with_cidr_blocks" {
  type        = list(map(string))
  description = "Ingress rules for security group"
  default     = []
}

variable "extra_ingress_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "Extra CIDR blocks allowed to access RDS (VPN / App)"
}

################################################################################
# New Variables for Multiple DB Instances
################################################################################

variable "db_instances" {
  type = map(object({
    identifier              = string
    engine_version          = string
    family                  = string
    major_engine_version    = string
    instance_class          = string
    allocated_storage       = string
    db_name                 = string
    master_username         = string
    multi_az                = bool
    publicly_accessible     = bool
    db_subnet_group_name    = string
    backup_retention_period = optional(number, 0)
    deletion_protection     = optional(bool, true)
    parameters = optional(list(object({
      name  = string
      value = string
      })), [
      {
        name  = "autovacuum"
        value = "1"
      },
      {
        name  = "client_encoding"
        value = "utf8"
      }
    ])
    tags = optional(map(string), {})
  }))
  description = "Map of database instances to create"
  default     = null
}
