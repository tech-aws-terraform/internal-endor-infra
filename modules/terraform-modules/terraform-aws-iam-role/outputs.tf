output "auth_lambda_role_name" {
  description = "Auth Lambda Role Name"
  value       = concat(aws_iam_role.auth_lambda_iam_role.*.name, [""])[0]
}

output "auth_lambda_role_name_arn" {
  description = "Auth Lambda Role ARN"
  value       = concat(aws_iam_role.auth_lambda_iam_role.*.arn, [""])[0]
}

output "transfer_lambda_role_name" {
  description = "Transfer Lambda Role Name"
  value       = concat(aws_iam_role.transfer_lambda_iam_role.*.name, [""])[0]
}

output "transfer_lambda_role_name_arn" {
  description = "Transfer Lambda Role ARN"
  value       = concat(aws_iam_role.transfer_lambda_iam_role.*.arn, [""])[0]
}

output "approval_lambda_role_name" {
  description = "Approval Lambda Role Name"
  value       = concat(aws_iam_role.approval_lambda_iam_role.*.name, [""])[0]
}

output "approval_lambda_role_name_arn" {
  description = "Approval Lambda Role ARN"
  value       = concat(aws_iam_role.approval_lambda_iam_role.*.arn, [""])[0]
}

output "ingest_lambda_role_name" {
  description = "Ingest Lambda Role Name"
  value       = concat(aws_iam_role.ingest_lambda_iam_role.*.name, [""])[0]
}

output "ingest_lambda_role_name_arn" {
  description = "Ingest Lambda Role ARN"
  value       = concat(aws_iam_role.ingest_lambda_iam_role.*.arn, [""])[0]
}

output "infra_iam_role_name" {
  description = "Infra Role Name"
  value       = concat(aws_iam_role.enclave_infra_iam_role.*.name, [""])[0]
}

output "infra_iam_role_arn" {
  description = "Infra Role ARN"
  value       = concat(aws_iam_role.enclave_infra_iam_role.*.arn, [""])[0]
}

/*output "appsync_dyanmodb_iam_role_name" {
  description = "Appsync Role Name"
  value       = concat(aws_iam_role.appsync_dynamodb_role.*.name, [""])[0]
}

output "appsync_dynamodb_iam_role_arn" {
  description = "Appsync Role ARN"
  value       = concat(aws_iam_role.appsync_dynamodb_role.*.arn, [""])[0]
}

output "appsync_cw_iam_role_name" {
  description = "Appsync CloudWatch Role Name"
  value       = concat(aws_iam_role.appsync_cw_role.*.name, [""])[0]
}

output "appsync_cw_iam_role_arn" {
  description = "Appsync CloudWatch Infra Role ARN"
  value       = concat(aws_iam_role.appsync_cw_role.*.arn, [""])[0]
}

output "appsync_admin_service_iam_role_name" {
  description = "Appsync Admin Service Infra Role Name"
  value       = concat(aws_iam_role.appsync_admin_service_http_role.*.name, [""])[0]
}

output "appsync_admin_service_iam_role_arn" {
  description = "Appsync Admin Service Infra Role ARN"
  value       = concat(aws_iam_role.appsync_admin_service_http_role.*.arn, [""])[0]
}*/

output "study_invoke_api_role_name" {
  description = "Study Invoke API Role Name"
  value       = concat(aws_iam_role.study_invoke_api_iam_role.*.name, [""])[0]
}

output "study_invoke_api_role_name_arn" {
  description = "Project Invoke API Role ARN"
  value       = concat(aws_iam_role.study_invoke_api_iam_role.*.arn, [""])[0]
}

#Glue Job starts
output "glue_job_iam_role_name" {
  description = "Glue Job Role Name"
  value       = concat(aws_iam_role.glue_job_iam_role.*.name, [""])[0]
}

output "glue_job_iam_role_arn" {
  description = "Glue Job Role ARN"
  value       = concat(aws_iam_role.glue_job_iam_role.*.arn, [""])[0]
}
#Glue Job ends

output "apigw_cw_role_name" {
  description = "API Gateway CW Role Name"
  value       = concat(aws_iam_role.apigw_cw_role.*.name, [""])[0]
}

output "apigw_cw_role_arn" {
  description = "API Gateway CW Role ARN"
  value       = concat(aws_iam_role.apigw_cw_role.*.arn, [""])[0]
}

# Org Catalog
output "org_catalog_fm_lambda_role_name" {
  description = "Org Catalog FM Lambda Role Name"
  value       = concat(aws_iam_role.org_catalog_fm_lambda_iam_role.*.name, [""])[0]
}

output "org_catalog_fm_lambda_role_name_arn" {
  description = "Org Catalog FM Lambda Role ARN"
  value       = concat(aws_iam_role.org_catalog_fm_lambda_iam_role.*.arn, [""])[0]
}

output "org_catalog_data_access_fm_lambda_role_name" {
  description = "Org Catalog Data Access File Movement Lambda Role Name"
  value       = concat(aws_iam_role.org_catalog_data_access_fm_lambda_iam_role.*.name, [""])[0]
}

output "org_catalog_data_access_fm_lambda_role_name_arn" {
  description = "Org Catalog Data Accesss File Movement Lambda Role ARN"
  value       = concat(aws_iam_role.org_catalog_data_access_fm_lambda_iam_role.*.arn, [""])[0]
}

output "org_catalog_download_lambda_role_name" {
  description = "Org Catalog Download Movement Lambda Role Name"
  value       = concat(aws_iam_role.org_catalog_download_lambda_iam_role.*.name, [""])[0]
}

output "org_catalog_download_lambda_role_name_arn" {
  description = "Org Catalog Download Lambda Role ARN"
  value       = concat(aws_iam_role.org_catalog_download_lambda_iam_role.*.arn, [""])[0]
}

output "neptune_duplicate_execution_check_lambda_role_name_arn" {
  description = "Neptune Opensearch Stream Duplicate Execution check Lambda"
  value       = concat(aws_iam_role.neptune_duplicate_execution_check_lambda_iam_role.*.arn, [""])[0]
}

output "neptune_opensearch_stream_poller_lambda_role_name_arn" {
  description = "Neptune Opensearch Stream Poller Lambda Role ARN"
  value       = concat(aws_iam_role.neptune_opensearch_stream_poller_lambda_iam_role.*.arn, [""])[0]
}

output "neptune_restart_statemachine_lambda_role_name_arn" {
  description = "Neptune Opensearch Stream Restart Statemachine Lambda Role ARN"
  value       = concat(aws_iam_role.neptune_restart_statemachine_lambda_iam_role.*.arn, [""])[0]
}

output "neptune_stream_poller_step_function_name_arn" {
  description = "Neptune Opensearch Stream Poller Step Function Role ARN"
  value       = concat(aws_iam_role.neptune_stream_poller_step_function_iam_role.*.arn, [""])[0]
}

# Enclave Specific Resources
output "enclave_specific_ingest_lambda_role_name" {
  description = "Enclave Specific Ingest Lambda Role Name"
  value       = var.enclave_specific_resource ? concat(aws_iam_role.enclave_specific_ingest_lambda_iam_role.*.name, [""])[0] : null
}

output "enclave_specific_ingest_lambda_role_name_arn" {
  description = "Enclave Specific Ingest Lambda Role ARN"
  value       = var.enclave_specific_resource ? concat(aws_iam_role.enclave_specific_ingest_lambda_iam_role.*.arn, [""])[0] : null
}