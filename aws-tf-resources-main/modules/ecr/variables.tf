variable "region" {
  type    = string
  default = "me-central-1"
}

variable "env" {
  type = string
}

variable "repository_name" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}