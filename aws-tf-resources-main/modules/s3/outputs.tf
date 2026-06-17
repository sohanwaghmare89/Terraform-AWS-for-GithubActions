output "s3_bucket_ids" {
  description = "The IDs of the created S3 buckets"
  value       = [for bucket in module.s3_bucket : bucket.s3_bucket_id]
}

output "s3_bucket_arns" {
  description = "The ARNs of the created S3 buckets"
  value       = [for bucket in module.s3_bucket : bucket.s3_bucket_arn]
}
