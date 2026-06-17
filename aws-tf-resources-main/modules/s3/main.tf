################################################################################
# S3 Module
################################################################################
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  count  = length(var.bucket_name)
  bucket = var.bucket_name[count.index]
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }

  tags = var.tags[count.index]
}
