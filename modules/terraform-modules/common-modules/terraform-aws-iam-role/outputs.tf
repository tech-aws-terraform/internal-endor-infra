output "role_name" {
  description = "Role Name"
  value       = concat(aws_iam_role.iam_role.*.name, [""])[0]
}

output "role_arn" {
  description = "Role ARN"
  value       = concat(aws_iam_role.iam_role.*.arn, [""])[0]
}

output "service_role_name" {
  description = "Service Role Name"
  value       = concat(aws_iam_service_linked_role.service_role.*.name, [""])[0]
}

output "service_role_arn" {
  description = "Service Role ARN"
  value       =  concat(aws_iam_service_linked_role.service_role.*.arn, [""])[0]
}
