variable "region" {
  type    = string
  default = "me-central-1"
}

variable "bucket_name" {
  type = list(string)
}

variable "tags" {
  type = list(map(string))
}
