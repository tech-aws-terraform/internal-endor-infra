
output "cost_usage_report_definition_arn" {
  description = "The ARN of the CUR definition"
  value       = var.enable_cur_report ? concat(aws_cur_report_definition.kamino_cur_report_definition.*.arn, [""])[0] : null
}

output "cost_usage_report_replication_role_arn" {
  description = "The ARN of the CUR Replication Role"
  value       = var.cost_bucket_replication ? concat(aws_iam_role.replication.*.arn, [""])[0] : null
}

output "cost_usage_report_replication_role_name" {
  description = "The CUR Replication Role ID"
  value       = var.cost_bucket_replication ? concat(aws_iam_role.replication.*.id, [""])[0] : null
}

output "billing_bucket_arn" {
  description = "The ARN of the Billing Bucket"
  value       = var.enable_cur_report ? concat(module.billing_bucket.*.bucket_arn, [""])[0] : null
}

output "billing_bucket_name" {
  description = "The Billing Bucket ID"
  value       = var.enable_cur_report ? concat(module.billing_bucket.*.bucket_id, [""])[0] : null
}