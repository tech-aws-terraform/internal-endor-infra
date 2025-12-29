output "auth_lambda_role_name" {
  description = "Auth Lambda Role Name"
  value       = concat(module.roles_policies.*.auth_lambda_role_name, [""])[0]
}

output "auth_lambda_role_name_arn" {
  description = "Auth Lambda Role ARN"
  value       = concat(module.roles_policies.*.auth_lambda_role_name_arn, [""])[0]
}

output "transfer_lambda_role_name" {
  description = "Transfer Lambda Role Name"
  value       = concat(module.roles_policies.*.transfer_lambda_role_name, [""])[0]
}

output "transfer_lambda_role_name_arn" {
  description = "Transfer Lambda Role ARN"
  value       = concat(module.roles_policies.*.transfer_lambda_role_name_arn, [""])[0]
}

output "approval_lambda_role_name" {
  description = "Approval Lambda Role Name"
  value       = concat(module.roles_policies.*.approval_lambda_role_name, [""])[0]
}

output "approval_lambda_role_name_arn" {
  description = "Approval Lambda Role ARN"
  value       = concat(module.roles_policies.*.approval_lambda_role_name_arn, [""])[0]
}

output "ingest_lambda_role_name" {
  description = "Ingest Lambda Role Name"
  value       = concat(module.roles_policies.*.ingest_lambda_role_name, [""])[0]
}

output "ingest_lambda_role_name_arn" {
  description = "Ingest Lambda Role ARN"
  value       = concat(module.roles_policies.*.ingest_lambda_role_name_arn, [""])[0]
}

output "infra_iam_role_name" {
  description = "starcap Infra Role Name"
  value       = concat(module.roles_policies.*.infra_iam_role_name, [""])[0]
}

output "infra_iam_role_arn" {
  description = "Starcap Infra Role ARN"
  value       = concat(module.roles_policies.*.infra_iam_role_arn, [""])[0]
}

output "auth_lambda_arn" {
  description = "Auth Lambda ARN"
  value       = concat(module.auth_lambda.*.lambda_arn, [""])[0]
}

output "transfer_lambda_arn" {
  description = "Transfer Lambda ARN"
  value       = concat(module.transfer_lambda.*.lambda_arn, [""])[0]
}

output "stage_s3_bucket_arn" {
  description = "Stage bucket arn"
  value       = concat(module.stage_bucket.*.bucket_arn, [""])[0]
}

output "stage_s3_bucket_id" {
  description = "Stage bucket Id"
  value       = concat(module.stage_bucket.*.bucket_id, [""])[0]
}

# output "stage_s3_bucket_name" {
#   description = "Stage bucket Id"
#   value       = concat(module.stage_bucket.*.s3_bucket_name, [""])[0]
# }

output "approval_lambda_arn" {
  description = "Transfer Lambda ARN"
  value       = concat(module.approval_lambda.*.lambda_arn, [""])[0]
}

output "ingest_s3_bucket_arn" {
  description = "Ingest bucket arn"
  value       = concat(module.ingest_bucket.*.bucket_arn, [""])[0]
}

output "ingest_s3_bucket_id" {
  description = "Ingest bucket Id"
  value       = concat(module.ingest_bucket.*.bucket_id, [""])[0]
}

# output "ingest_s3_bucket_name" {
#   description = "Ingest bucket Id"
#   value       = concat(module.ingest_bucket.*.s3_bucket_name, [""])[0]
# }

output "ingest_lambda_arn" {
  description = "Ingest Lambda ARN"
  value       = concat(module.ingest_lambda.*.lambda_arn, [""])[0]
}

output "study_sci_ingress_data_s3_bucket_arn" {
  description = "Study Scientific bucket arn"
  value       = concat(module.study_sci_ingress_data_bucket.*.bucket_arn, [""])[0]
}

output "study_sci_ingress_data_s3_bucket_id" {
  description = "Study Scientific bucket Id"
  value       = concat(module.study_sci_ingress_data_bucket.*.bucket_id, [""])[0]
}

# output "study_sci_ingress_data_s3_bucket_name" {
#   description = "Study Scientific bucket Id"
#   value       = concat(module.study_sci_ingress_data_bucket.*.s3_bucket_name, [""])[0]
# }

output "ptfm_dynamodb_table_arn" {
  description = "The ARN of the dynamo DB table"
  value       = module.dynamodb_table.dynamodb_table_arn
}

output "dynamodb_table_id" {
  description = "The name of the dynamo DB table"
  value       = module.dynamodb_table.dynamodb_table_id
}

/*output "appsync_dyanmodb_iam_role_name" {
  description = "Appsync Role Name"
  value       = concat(module.roles_policies.*.appsync_dyanmodb_iam_role_name, [""])[0]
}

output "appsync_dynamodb_iam_role_arn" {
  description = "Appsync Role ARN"
  value       = concat(module.roles_policies.*.appsync_dynamodb_iam_role_arn, [""])[0]
}

output "appsync_cw_iam_role_name" {
  description = "Appsync CloudWatch Role Name"
  value       = concat(module.roles_policies.*.appsync_cw_iam_role_name, [""])[0]
}

output "appsync_cw_iam_role_arn" {
  description = "Appsync CloudWatch Infra Role ARN"
  value       = concat(module.roles_policies.*.appsync_cw_iam_role_arn, [""])[0]
}

output "appsync_admin_service_iam_role_name" {
  description = "Appsync Admin Service Infra Role Name"
  value       = concat(module.roles_policies.*.appsync_admin_service_iam_role_name, [""])[0]
}

output "appsync_admin_service_iam_role_arn" {
  description = "Appsync Admin Service Infra Role ARN"
  value       = concat(module.roles_policies.*.appsync_admin_service_iam_role_arn, [""])[0]
}

output "appsync_api_id" {
  description = "Appsync API id"
  value       = concat(module.appsync.*.appsync_api_id, [""])[0]
}

output "appsync_api_uris" {
  description = "Appsync API uris"
  value       = concat(module.appsync.*.appsync_api_uris, [""])[0]
}

output "appsync_arn" {
  description = "Appsync ARN"
  value       = concat(module.appsync.*.appsync_arn, [""])[0]
}

output "api_key_id" {
  description = "API Key ID"
  value       = concat(module.appsync.*.api_key_id, [""])[0]
}*/

output "sqs_queue_id" {
  description = "Starcap Endor SQS Queue Id"
  value       = concat(module.sqs_queue.*.sqs_queue_id, [""])[0]
}

output "sqs_queue_arn" {
  description = "Starcap Endor SQS Queue ARN"
  value       = concat(module.sqs_queue.*.sqs_queue_arn, [""])[0]
}

output "transfer_secure_api_id" {
  description = "Starcap Transfer Secure API Gateway ARN"
  value       = concat(module.api_gateway.*.transfer_secure_api_id, [""])[0]
}

output "transfer_secure_api_arn" {
  description = "Starcap Transfer Secure API Gateway ARN"
  value       = concat(module.api_gateway.*.transfer_secure_api_arn, [""])[0]
}

output "transfer_secure_api_execution_arn" {
  description = "Starcap Transfer Secure API Gateway execution arn"
  value       = concat(module.api_gateway.*.transfer_secure_api_execution_arn, [""])[0]
}

output "transfer_secure_api_stage_id" {
  description = "Starcap Transfer Secure API Gateway Stage ID"
  value       = concat(module.api_gateway.*.transfer_secure_api_stage_id, [""])[0]
}

output "transfer_secure_api_stage_arn" {
  description = "Starcap Transfer Secure API Gateway stage ARN"
  value       = concat(module.api_gateway.*.transfer_secure_api_stage_arn, [""])[0]
}

output "transfer_secure_api_stage_invoke_url" {
  description = "Starcap Transfer Secure API Gateway stage Invoke URL"
  value       = concat(module.api_gateway.*.transfer_secure_api_stage_invoke_url, [""])[0]
}

output "waf_arn" {
  description = "WAF ARN"
  value = concat(module.waf.*.waf_arn, [""])[0]
}

output "waf_id" {
  description = "WAF ID"
  value = concat(module.waf.*.waf_id, [""])[0]
}

output "study_support_data_s3_bucket_arn" {
  description = "File Upload bucket arn"
  value       = concat(module.study_supportive_data_bucket.*.bucket_arn, [""])[0]
}

output "study_support_data_s3_bucket_name" {
  description = "File Upload bucket Id"
  value       = concat(module.study_supportive_data_bucket.*.bucket_id, [""])[0]
}

output "prestage_s3_bucket_arn" {
  description = "File Upload bucket arn"
  value       = concat(module.prestage_bucket.*.bucket_arn, [""])[0]
}

output "prestage_s3_bucket_id" {
  description = "File Upload bucket Id"
  value       = concat(module.prestage_bucket.*.bucket_id, [""])[0]
}
# output "prestage_s3_bucket_name" {
#   description = "File Upload bucket Id"
#   value       = concat(module.prestage_bucket.*.s3_bucket_name, [""])[0]
# }

#Glue Job starts
output "glue_job_iam_role_name" {
  description = "Glue Job Role Name"
  value       = concat(module.glue_job_roles_policies.*.glue_job_iam_role_name, [""])[0]
}

output "glue_job_iam_role_arn" {
  description = "Glue Job Role ARN"
  value       = concat(module.glue_job_roles_policies.*.glue_job_iam_role_arn, [""])[0]
}

# output "transfer_glue_etl_job_arn" {
#   description = "Ingest Glue ETL Job ARN"
#   value       = concat(module.transfer_glue.*.glue_etl_job_arn, [""])[0]
# }

# output "transfer_glue_etl_job_id" {
#   description = "Ingest Glue ETL Job ARN"
#   value       = concat(module.transfer_glue.*.glue_etl_job_id, [""])[0]
# }

# output "approval_glue_etl_job_arn" {
#   description = "Ingest Glue ETL Job ARN"
#   value       = concat(module.approval_glue.*.glue_etl_job_arn, [""])[0]
# }

# output "approval_glue_etl_job_id" {
#   description = "Ingest Glue ETL Job ARN"
#   value       = concat(module.approval_glue.*.glue_etl_job_id, [""])[0]
# }

# output "ingest_glue_etl_job_arn" {
#   description = "Ingest Glue ETL Job ARN"
#   value       = concat(module.ingest_glue.*.glue_etl_job_arn, [""])[0]
# }

# output "ingest_glue_etl_job_id" {
#   description = "Ingest Glue ETL Job ARN"
#   value       = concat(module.ingest_glue.*.glue_etl_job_id, [""])[0]
# }
#Glue Job ends

# Org Catalog
output "org_catalog_vpc" {
  description = "Org Catalog VPC"
  value       = concat(module.org_catalog_vpc.*.vpc_id, [""])[0]
}

output "vpc_peer_id" {
  description = "VPC Peer ID"
  value       = concat(module.vpc_peering.*.peer_id, [""])[0]
}

# Enclave Specific Resources
output "enclave_specific_ingest_lambda_role_name" {
  description = "Enclave Specific Ingest Lambda Role Name"
  value       = var.enclave_specific_resource ? concat(module.roles_policies.*.enclave_specific_ingest_lambda_role_name, [""])[0] : null
}

output "enclave_specific_ingest_lambda_role_name_arn" {
  description = "Enclave Specific Ingest Lambda Role ARN"
  value       = var.enclave_specific_resource ? concat(module.roles_policies.*.enclave_specific_ingest_lambda_role_name_arn, [""])[0] : null
}

output "enclave_specific_ingest_lambda_arn" {
  description = "Enclave Specific Ingest Lambda ARN"
  value       = var.enclave_specific_resource ? concat(module.enclave_specific_ingest_lambda.*.lambda_arn, [""])[0] : null
}

output "enclave_specific_ingest_glue_etl_job_arn" {
  description = "Enclave Specific Ingest Glue ETL Job ARN"
  value       = var.enclave_specific_resource ? concat(module.enclave_specific_ingest_glue.*.glue_etl_job_arn, [""])[0] : null
}

output "enclave_specific_ingest_glue_etl_job_id" {
  description = "Enclave Specific Ingest Glue ETL Job ARN"
  value       = var.enclave_specific_resource ? concat(module.enclave_specific_ingest_glue.*.glue_etl_job_id, [""])[0] : null
}

output "lease_dynamodb_table_arn" {
  description = "The ARN of the Lease dynamo DB table"
  value       = var.create_neptune_poller_table ? concat(module.neptune_opensearch_poller_dynamodb_table.*.lease_dynamodb_table_arn, [""])[0] : null
}

output "org_catalog_bucket_s3_bucket_arn" {
  description = "Org Catalog bucket arn"
  value       = concat(module.org_catalog_s3.*.bucket_arn, [""])[0]
}

output "org_catalog_bucket_s3_bucket_id" {
  description = "Org Catalog bucket Id"
  value       = concat(module.org_catalog_s3.*.bucket_id, [""])[0]
}

output "open_search_endpoint" {
  description = "The ARN of opensearch endpoint"
  value       = concat(module.opensearch_serverless.*.oss_collection_endpoint, [""])[0]
}

output "neptune_write_endpoint" {
  description = "The ARN of neptune write endpoint"
  value       = concat(module.neptune_clusters.*.neptune_writer_endpoint, [""])[0]
}

output "neptune_iam_role_arn" {
  description = "The ARN of neptune iam role"
  value       = concat(module.neptune_clusters.*.neptune_iam_auth_role_arn, [""])[0]
}

output "neptune_iam_role_name" {
  description = "The Name of neptune iam role"
  value       = concat(module.neptune_clusters.*.neptune_iam_auth_role_id, [""])[0]
}

output "neptune_cluster_identifier" {
  description = "The Name of neptune cluster"
  value       = concat(module.neptune_clusters.*.neptune_cluster_id, [""])[0]
}

#budget iam role
output "budget_role_arn" {
  description = "The ARN of the Budget Role"
  value       = var.enable_budget ? concat(aws_iam_role.budget.*.arn, [""])[0] : null
}

output "budget_role_name" {
  description = "The Budget Role ID"
  value       = var.enable_budget ? concat(aws_iam_role.budget.*.id, [""])[0] : null
}