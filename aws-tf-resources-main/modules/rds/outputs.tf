################################################################################
# Legacy Outputs (for backward compatibility with staging)
################################################################################

output "db_instance_address" {
  description = "The address of the RDS instance (legacy - default instance)"
  value       = try(module.db["default"].db_instance_address, null)
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance (legacy - default instance)"
  value       = try(module.db["default"].db_instance_arn, null)
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance (legacy - default instance)"
  value       = try(module.db["default"].db_instance_availability_zone, null)
}

output "db_instance_endpoint" {
  description = "The connection endpoint (legacy - default instance)"
  value       = try(module.db["default"].db_instance_endpoint, null)
}

output "db_instance_engine" {
  description = "The database engine (legacy - default instance)"
  value       = try(module.db["default"].db_instance_engine, null)
}

output "db_instance_engine_version_actual" {
  description = "The running version of the database (legacy - default instance)"
  value       = try(module.db["default"].db_instance_engine_version_actual, null)
}

output "db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (legacy - default instance)"
  value       = try(module.db["default"].db_instance_hosted_zone_id, null)
}

output "db_instance_identifier" {
  description = "The RDS instance identifier (legacy - default instance)"
  value       = try(module.db["default"].db_instance_identifier, null)
}

output "db_instance_resource_id" {
  description = "The RDS Resource ID of this instance (legacy - default instance)"
  value       = try(module.db["default"].db_instance_resource_id, null)
}

output "db_instance_status" {
  description = "The RDS instance status (legacy - default instance)"
  value       = try(module.db["default"].db_instance_status, null)
}

output "db_instance_name" {
  description = "The database name (legacy - default instance)"
  value       = try(module.db["default"].db_instance_name, null)
}

output "db_instance_username" {
  description = "The master username for the database (legacy - default instance)"
  value       = try(module.db["default"].db_instance_username, null)
  sensitive   = true
}

output "db_instance_port" {
  description = "The database port (legacy - default instance)"
  value       = try(module.db["default"].db_instance_port, null)
}

output "db_subnet_group_id" {
  description = "The db subnet group name (legacy - default instance)"
  value       = try(module.db["default"].db_subnet_group_id, null)
}

output "db_subnet_group_arn" {
  description = "The ARN of the db subnet group (legacy - default instance)"
  value       = try(module.db["default"].db_subnet_group_arn, null)
}

output "db_parameter_group_id" {
  description = "The db parameter group id (legacy - default instance)"
  value       = try(module.db["default"].db_parameter_group_id, null)
}

output "db_parameter_group_arn" {
  description = "The ARN of the db parameter group (legacy - default instance)"
  value       = try(module.db["default"].db_parameter_group_arn, null)
}

output "db_enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the monitoring role (legacy - default instance)"
  value       = try(module.db["default"].enhanced_monitoring_iam_role_arn, null)
}

output "db_instance_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes (legacy - default instance)"
  value       = try(module.db["default"].db_instance_cloudwatch_log_groups, null)
}

output "db_instance_master_user_secret_arn" {
  description = "The ARN of the master user secret (legacy - default instance)"
  value       = try(module.db["default"].db_instance_master_user_secret_arn, null)
}

output "db_instance_secretsmanager_secret_rotation_enabled" {
  description = "Specifies whether automatic rotation is enabled for the secret (legacy - default instance)"
  value       = try(module.db["default"].db_instance_secretsmanager_secret_rotation_enabled, null)
}

################################################################################
# New Outputs for Multiple DB Instances
################################################################################

output "db_instances" {
  description = "Map of all database instances and their attributes"
  value = {
    for key, instance in module.db : key => {
      address                                = instance.db_instance_address
      arn                                    = instance.db_instance_arn
      availability_zone                      = instance.db_instance_availability_zone
      endpoint                               = instance.db_instance_endpoint
      engine                                 = instance.db_instance_engine
      engine_version_actual                  = instance.db_instance_engine_version_actual
      hosted_zone_id                         = instance.db_instance_hosted_zone_id
      identifier                             = instance.db_instance_identifier
      resource_id                            = instance.db_instance_resource_id
      status                                 = instance.db_instance_status
      name                                   = instance.db_instance_name
      port                                   = instance.db_instance_port
      subnet_group_id                        = instance.db_subnet_group_id
      subnet_group_arn                       = instance.db_subnet_group_arn
      parameter_group_id                     = instance.db_parameter_group_id
      parameter_group_arn                    = instance.db_parameter_group_arn
      enhanced_monitoring_iam_role_arn       = instance.enhanced_monitoring_iam_role_arn
      cloudwatch_log_groups                  = instance.db_instance_cloudwatch_log_groups
      master_user_secret_arn                 = instance.db_instance_master_user_secret_arn
      secretsmanager_secret_rotation_enabled = instance.db_instance_secretsmanager_secret_rotation_enabled
    }
  }
}

output "db_instances_endpoints" {
  description = "Map of database instance keys to their endpoints"
  value = {
    for key, instance in module.db : key => instance.db_instance_endpoint
  }
}

output "db_instances_identifiers" {
  description = "Map of database instance keys to their identifiers"
  value = {
    for key, instance in module.db : key => instance.db_instance_identifier
  }
}

output "security_groups" {
  description = "Map of security groups created for each database instance"
  value = {
    for key, sg in module.security_group : key => {
      id   = sg.security_group_id
      arn  = sg.security_group_arn
      name = sg.security_group_name
    }
  }
}