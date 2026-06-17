variable "region" {
  type    = string
  default = "me-central-1"
}

variable "name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "database_subnet_group_name" {
  type = string
}

variable "db_subnets" {
  type = list(string)
}

variable "intra_subnets" {
  type = list(string)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}