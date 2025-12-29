variable "create_roles_policies" {
  description = "Flag for IAM Roles Policies"
  type        = bool
  default     = false
}

variable "auth_lambda_iam_role_name" {
  description = "Role name for Auth Lambda"
  type        = string
  default     = ""
}

variable "auth_lambda_policy_name" {
  description = "Policy name for Auth Lambda"
  type        = string
  default     = ""
}

variable "log_account_arn" {
  description = "Account Log ARN"
  type        = string
  default     = ""
}

variable "log_account_auth_lambda_arn" {
  description = "Account Log ARN with Lambda Function"
  type        = string
  default     = ""
}

variable "log_account_transfer_lambda_arn" {
  description = "Account Log ARN with Lambda Function"
  type        = string
  default     = ""
}

variable "log_account_approval_lambda_arn" {
  description = "Account Log ARN with Lambda Function"
  type        = string
  default     = ""
}

variable "log_account_ingest_lambda_arn" {
  description = "Account Log ARN with Lambda Function"
  type        = string
  default     = ""
}

variable "transfer_lambda_iam_role_name" {
  description = "Role name for Transfer Lambda"
  type        = string
  default     = ""
}

variable "transfer_lambda_policy_name" {
  description = "Policy name for Transfer Lambda"
  type        = string
  default     = ""
}

variable "approval_lambda_iam_role_name" {
  description = "Role name for Approval Lambda"
  type        = string
  default     = ""
}

variable "approval_lambda_policy_name" {
  description = "Policy name for Approval Lambda"
  type        = string
  default     = ""
}

variable "ingest_lambda_iam_role_name" {
  description = "Role name for Transfer Lambda"
  type        = string
  default     = ""
}

variable "ingest_lambda_policy_name" {
  description = "Policy name for Transfer Lambda"
  type        = string
  default     = ""
}

variable "role_max_session_duration" {
  description = "Maximum session duration (in seconds) that you want to set for the specified role"
  type        = string
  default     = "43200"
}

variable "tags" {
  type        = map(any)
  description = "Mapping of Tags of S3 Bucket"
  default     = {}
}

variable "ingest_bucket_arn" {
  description = "PTFM ingest bucket ARN"
  type        = string
  default     = ""
}

variable "ingest_bucket_folders_arn" {
  description = "PTFM ingest bucket folder ARN"
  type        = string
  default     = ""
}

variable "study_sci_ingress_data_bucket_arn" {
  description = "Study Scientific Ingress Data bucket ARN"
  type        = string
  default     = ""
}

variable "study_sci_ingress_data_bucket_folders_arn" {
  description = "Study Scientific Ingress Data bucket folder ARN"
  type        = string
  default     = ""
}

variable "enclave_infra_build_role" {
  description = "Role name for Infra Creation in Endor Account"
  type        = string
  default     = ""
}

variable "enclave_infra_build_policy" {
  description = "Policy name for Infra Creation in Endor Account"
  type        = string
  default     = ""
}

variable "endor_account_id" {
  description = "Endor Account ID"
  type        = string
  default     = ""
}

variable "product_name" {
  description = "Product Name"
  type        = string
  default     = ""
}

variable "appsync_dynamodb_role_name" {
  description = "Appsync DynamoDB Role"
  type        = string
  default     = ""
}

variable "appsync_dynamodb_policy_name" {
  description = "Appsync DynamoDB Policy"
  type        = string
  default     = ""
}

variable "dynamodb_table_arn" {
  description = "Enclave DynamoDB Table Name"
  type        = string
  default     = ""
}

variable "appsync_cw_role_name" {
  description = "Enclave AppSync CloudWatch Role Name"
  type        = string
  default     = ""
}

variable "appsync_admin_service_http_role_name" {
  description = "AppSync Admin Service Role Name"
  type        = string
  default     = ""
}

variable "enclave_trust_iam_roles" {
  description = "Enclave TrustRelationShip Role"
  type        = list(string)
  default     = []
}

variable "appsync_rolename" {
  description = "Appsync Role Name"
  type        = string
  default     = ""
}

#DEV_1292047_project_infra_creation starts
variable "create_study_roles_policies" {
  description = "Study IAM Role Creation Flag"
  type        = bool
  default     = false
}

variable "study_s3_transfer_family_role" {
  description = "Transfer Family Role name for Process Access"
  type        = string
  default     = ""
}

variable "study_s3_transfer_family_role_policy" {
  description = "Transfer Family Policy name for Project Access"
  type        = string
  default     = ""
}

variable "study_s3_bucket_arn" {
  description = "Project SFTP S3 bucket ARN"
  type        = string
  default     = ""
}

variable "study_s3_bucket_arn_list" {
  description = "Project SFTP S3 bucket ARN list"
  type        = string
  default     = ""
}

variable "study_s3_bucket_arn_exe_deny" {
  description = "Project SFTP S3 bucket ARN Deny file"
  type        = string
  default     = ""
}

variable "study_s3_bucket_arn_exe_deny_file_part" {
  description = "Project SFTP S3 bucket ARN Deny file part"
  type        = string
  default     = ""
}
#DEV_1292047_project_infra_creation ends

#DEV_1266952_creating-transfer-family-with-waf-apigw starts
variable "study_invoke_api_role_name" {
  description = "Role name for SFTP - Invoke API Invoke"
  type        = string
  default     = ""
}

variable "study_invoke_api_policy_name" {
  description = "Policy name for SFTP - Invoke API Invoke"
  type        = string
  default     = ""
}

variable "region" {
  description = "The Region Name where Endor AWS resources will be deployed"
  type        = string
  default     = "eu-central-1"
}

variable "apigw_id" {
  description = "API GW ID"
  type        = string
  default     = ""
}
#DEV_1266952_creating-transfer-family-with-waf-apigw ends

#Glue Job starts
variable "create_glue_job_roles_policies" {
  description = "Glue Job Flag"
  type        = bool
  default     = false
}

variable "glue_job_role_name" {
  description = "Role name for Glue Job"
  type        = string
  default     = ""
}

variable "glue_job_cw_metric_policy_name" {
  description = "Policy name for Glue Job CW Metric"
  type        = string
  default     = ""
}

variable "glue_job_dynamodb_policy_name" {
  description = "Policy name for Glue Job CW Metric"
  type        = string
  default     = ""
}

# variable "transfer_glue_job_arn" {
#   description = "Transfer Glue Job ARN"
#   type        = string
#   default     = ""
# }

# variable "approval_glue_job_arn" {
#   description = "Approval Glue Job ARN"
#   type        = string
#   default     = ""
# }

# variable "ingest_glue_job_arn" {
#   description = "Ingest Glue Job ARN"
#   type        = string
#   default     = ""
# }
#Glue Job ends

# API Gateway
variable "apigw_cw_role_name" {
  description = "API Gateway Role"
  type        = string
  default     = ""
}

variable "apigw_cw_policy_name" {
  description = "API Gateway Policy"
  type        = string
  default     = ""
}

# Org Catalog

variable "create_org_catalog" {
  description = "create infra for org catalog"
  type        = bool
  default     = false
}

variable "org_catalog_fm_lambda_iam_role_name" {
  description = "Role name for Org Catalog File Movement Lambda"
  type        = string
  default     = ""
}

variable "org_catalog_fm_lambda_policy_name" {
  description = "Policy name for Org Catalog File Movement Lambda"
  type        = string
  default     = ""
}

variable "log_account_org_catalog_fm_lambda_arn" {
  description = "Account Log ARN with Org Catalog File Movement Lambda Function"
  type        = string
  default     = ""
}

variable "org_catalog_fm_glue_job_arn" {
  description = "Org Catalog File Movement Glue Job ARN"
  type        = string
  default     = ""
}

variable "org_catalog_data_access_fm_lambda_iam_role_name" {
  description = "Role name for Org Catalog Data Access File Movement Lambda"
  type        = string
  default     = ""
}

variable "org_catalog_data_access_fm_lambda_policy_name" {
  description = "Policy name for Org Catalog Data Access File Movement Lambda"
  type        = string
  default     = ""
}

variable "log_account_org_catalog_data_access_fm_lambda_arn" {
  description = "Account Log ARN with Org Catalog Data Access File Movement Lambda Function"
  type        = string
  default     = ""
}

variable "org_catalog_data_access_fm_glue_job_arn" {
  description = "Org Catalog Data Access File Movement Glue Job ARN"
  type        = string
  default     = ""
}

variable "org_catalog_download_lambda_iam_role_name" {
  description = "Role name for Org Catalog Download Lambda"
  type        = string
  default     = ""
}

variable "org_catalog_download_lambda_policy_name" {
  description = "Policy name for Org Catalog Download Lambda"
  type        = string
  default     = ""
}

variable "log_account_org_catalog_download_lambda_arn" {
  description = "Account Log ARN with Org Catalog Download Lambda Function"
  type        = string
  default     = ""
}

variable "org_catalog_download_glue_job_arn" {
  description = "Org Catalog Download Glue Job ARN"
  type        = string
  default     = ""
}

#Neptune Opensearch Stream Duplicate Execution check Lambda
variable "neptune_duplicate_execution_check_lambda_iam_role_name" {
  description = "Role name for Neptune Opensearch Stream Duplicate Execution check Lambda"
  type        = string
  default     = ""
}

variable "neptune_duplicate_execution_check_lambda_policy_name" {
  description = "Policy name for Neptune Opensearch Stream Duplicate Execution check Lambda"
  type        = string
  default     = ""
}

variable "lease_db_table_arn" {
  description = "lease table DB ARN"
  type        = string
  default     = ""
}

#Neptune Opensearch Stream Poller Lambda
variable "create_neptune_opensearch_stream_poller_lambda_iam_roles_policies" {
  description = "Flag for Stream Poller Lambda IAM Policies"
  type        = bool
  default     = false
}

variable "neptune_opensearch_stream_poller_lambda_iam_role_name" {
  description = "Role name for Neptune Opensearch Stream Poller Lambda"
  type        = string
  default     = ""
}

variable "neptune_opensearch_stream_poller_lambda_policy_name" {
  description = "Policy name for Neptune Opensearch Stream Poller Lambda"
  type        = string
  default     = ""
}

variable "neptune_db_arn" {
  description = "Neptune DB ARN"
  type        = string
  default     = ""
}

#Neptune Opensearch Stream Restart Statemachine Lambda
variable "neptune_restart_statemachine_lambda_iam_role_name" {
  description = "Role name for Neptune Opensearch Stream Restart Statemachine Lambda"
  type        = string
  default     = ""
}

variable "neptune_restart_statemachine_lambda_policy_name" {
  description = "Policy name for Neptune Opensearch Stream Restart Statemachine Lambda"
  type        = string
  default     = ""
}

#Neptune Opensearch Stream Poller Step Function
variable "neptune_stream_poller_step_function_iam_role_name" {
  description = "Role name for Neptune Opensearch Stream Poller Step Function"
  type        = string
  default     = ""
}

variable "neptune_stream_poller_step_function_policy_name" {
  description = "Policy name for Neptune Opensearch Stream Poller Step Function"
  type        = string
  default     = ""
}

# Enclave Specific Resources
variable "enclave_specific_resource" {
  description = "Enclave Specific Resource Flag"
  type        = bool
  default     = false
}

variable "enclave_specific_ingest_lambda_iam_role_name" {
  description = "Role name for Enclave Specific Ingest Lambda"
  type        = string
  default     = ""
}

variable "enclave_specific_ingest_lambda_policy_name" {
  description = "Policy name for Enclave Specific Ingest Lambda"
  type        = string
  default     = ""
}

variable "enclave_specific_log_account_ingest_lambda_arn" {
  description = "Account Log ARN with Lambda Function"
  type        = string
  default     = ""
}

variable "enclave_specific_ingest_glue_job_arn" {
  description = "Enclave Specific Ingest Glue Job ARN"
  type        = string
  default     = ""
}
