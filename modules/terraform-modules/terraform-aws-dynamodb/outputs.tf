output "dynamodb_table_arn" {
  description = "The ARN of the PTFM dynamo DB table"
  value       = concat(aws_dynamodb_table.ptfm_dynamodb_table.*.arn, [""])[0]
}

output "dynamodb_table_id" {
  description = "The ID of the PTFM dynamo DB table"
  value       = concat(aws_dynamodb_table.ptfm_dynamodb_table.*.id, [""])[0]
}

output "dynamodb_table_name" {
  description = "The name of the PTFM dynamo DB table"
  value       = concat(aws_dynamodb_table.ptfm_dynamodb_table.*.name, [""])[0]
}

output "lease_dynamodb_table_arn" {
  description = "The ARN of the Lease dynamo DB table"
  value       = concat(aws_dynamodb_table.lease_dynamodb_table.*.arn, [""])[0]
}

output "lease_dynamodb_table_id" {
  description = "The ID of the Lease dynamo DB table"
  value       = concat(aws_dynamodb_table.lease_dynamodb_table.*.id, [""])[0]
}

output "lease_dynamodb_table_name" {
  description = "The name of the Lease dynamo DB table"
  value       = concat(aws_dynamodb_table.lease_dynamodb_table.*.name, [""])[0]
}