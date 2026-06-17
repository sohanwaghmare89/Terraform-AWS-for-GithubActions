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

variable "name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "instance_type" {
  type = string
}

variable "ami" {
  type        = string
  description = "AMI ID to use for the instance. If not provided, will use latest Ubuntu 22.04 AMI"
  default     = null
}