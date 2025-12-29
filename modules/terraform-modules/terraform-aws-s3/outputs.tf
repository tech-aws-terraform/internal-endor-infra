output "bucket_arn" {
  description = "Bucket arn"
  value       = concat(aws_s3_bucket.bucket.*.arn, [""])[0]
}

output "bucket_id" {
  description = "Bucket Id"
  value       = concat(aws_s3_bucket.bucket.*.id, [""])[0]
}