variable "enclave_key" {
  description = "The enclave id"
  type        = string
}

variable "enclave_region" {
  description = "The enclave region"
  type        = string
}

variable "enclave_domain_name" {
  description = "The enclave domain name"
  type        = string
}

variable "platform" {
  description = "The platform id"
  type        = string
  default     = "kamino"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

# IAM Roles Policies
variable "create_roles_policies" {
  description = "Flag for roles Policies"
  type        = bool
  default     = true
}

variable "endor_account_id" {
  description = "Environment"
  type        = string
}

/*variable "enclave_trust_iam_roles" {
  description = "Enclave TrustRelationShip Role"
  type        = list(string)
  default     = []
}*/

variable "enclave_engg_role" {
  description = "Enclave Enggineering Role"
  type        = string
  default     = ""
}

variable "enclave_devops_role" {
  description = "Enclave Devops Role"
  type        = string
  default     = ""
}

# Glue Job Roles Policies
variable "create_glue_job_roles_policies" {
  description = "Glue Job Roles Policies Flag"
  type        = bool
  default     = true
}

# Study Roles Policies
variable "create_study_roles_policies" {
  description = "Study Roles Policies Flag"
  type        = bool
  default     = true
}

# Dynamo DB
variable "point_in_time_recovery_enabled" {
  description = "Flag for creating PITR"
  type        = bool
  default     = true
}

# Glue
variable "command_name" {
  description = "Command Name"
  type        = string
  default     = "pythonshell"
}

variable "transfer_glue_script_location" {
  description = "The transfer Glue script location"
  type        = string
  default     = ""
}

variable "extra_py_files" {
  description = "Additional Python files configuration"
  type        = string
  default     = ""
}

variable "max_concurrent_runs" {
  description = "Maximum Concurrent runs"
  type        = number
  default     = 20
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "vpc_url" {
  description = "VPC URL"
  type        = string
  default     = ""
}

variable "max_capacity" {
  description = "The maximum number of AWS Glue data processing units (DPUs) that can be allocated when this job runs"
  type = number
  default = 1.0
}

variable "python_version" {
  description = "The Python version being used to execute a Python shell job. Allowed values are 2 or 3."
  type        = number
  default     = 3.9
}

variable "approval_glue_script_location" {
  description = "The Approval Glue script location"
  type        = string
  default     = ""
}

variable "ingest_glue_script_location" {
  description = "The Ingest Glue script location"
  type        = string
  default     = ""
}

# SQS queue
variable "enclave_account_id" {
  description = "Enclave Account ID"
  type        = string
  default     = ""
}

# Lambda
variable "runtime" {
  description = "Runtime Language"
  type        = string
  default     = "python3.9"
}

variable "lambda_handler" {
  description = "Lambda Handler Name"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "timeout" {
  description = "Lambda Timeout"
  type        = number
  default     = 900
}

# S3 Buckets
variable "s3_cors_origins" {
  description = "S3 Bucket CORS Origins"
  type        = list(string)
  default     = []
}

/*variable "enclave_root_iam_role" {
  description = "Enclave Root IAM Role"
  type        = list(string)
  default     = []
}*/

variable "prestaging_bucket_lc_rule" {
  description = "Map of S3 lifecycle rules"
  type = list(object({
    id                                  = string
    enabled                            = bool
    prefix                             = string
    tags                               = map(string)
    expiration_days                    = number
    expired_object_delete_marker       = bool
    noncurrent_version_expiration_days = number
  }))
  default = [
    {
      id                                = "qc"
      enabled                            = true
      prefix                             = "qc/"
      tags                                = {}
      expiration_days                    = 30
      expired_object_delete_marker       = false
      noncurrent_version_expiration_days = 30
    }
  ]
}

variable "bucket_lc_rule" {
  description = "Map of S3 lifecycle rules"
  type = list(object({
    id                                  = string
    enabled                            = bool
    prefix                             = string
    tags                               = map(string)
    expiration_days                    = number
    expired_object_delete_marker       = bool
    noncurrent_version_expiration_days = number
  }))
  default = [
    {
      id                                  = "all"
      enabled                            = true
      prefix                             = null
      tags                               =         {
          "apply_lifecycle_rule"  = "yes"
        }
      expiration_days                    = 30
      expired_object_delete_marker       = false
      noncurrent_version_expiration_days = 30
    }
  ]
}

# AppSync
variable "api_key_expires" {
  description = "RFC3339 string representation of the expiry date"
  type        = string
  default     = ""
}

# API Gateway
variable "api_gw_stage_name" {
  description = "API Gateway stage Name"
  type        = string
  default     = "dev"
}

variable "throttle_burst_lt" {
  description = "Starcap API Throttle Burst Limit"
  type        = number
  default     = 1000
}

variable "throttle_rate_lt" {
  description = "Starcap API Throttle Rate Limit"
  type        = number
  default     = 500
}

variable "api_resource_path" {
  description = "API Gateway resource path"
  type        = string
  default     = "/*/GET/sftp-auth/servers/*/users/*/config"
}

variable "logging_level" {
  description = "Logging Level"
  type        = string
  default     = "INFO"
}

# WAF
variable "scope" {
  description = "Scope of the WAF"
  type        = string
  default     = "REGIONAL"
}

variable "regex_pattern_str" {
  description = "Regex Patern String to Match the Rule"
  type        = string
  default     = "^[a-zA-Z0-9+/_.-]+%40[a-zA-Z0-9.-]"
}

# Org Catalog and Neptune
variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "neptune_subnets" {
  description = "A list of neptune subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "accepter_cidr" {
  description = "Accepter CIDR (Enclave Base VPC)"
  type        = string
}

variable "accepter_vpc_id" {
  description = "Accepter VPC ID (Enclave Base VPC)"
  type        = string
}

variable "instance_count" {
  description = "Total number of instance including writer and reader"
  type        = number
}

variable "min_nep_capacity" {
  description = "The minimum Neptune Capacity Units (NCUs) for the cluster"
  type        = number
}

variable "max_nep_capacity" {
  description = "The maximum Neptune Capacity Units (NCUs) for the cluster"
  type        = number
}

variable "create_neptune_notebook" {
  description = "Create Neptune Notebook"
  type        = bool
  default     = false
}

variable "enclave_base_vpc_cidr" {
  description = "A list of subnet CIDRs from where neptune will be connected"
  type        = list(string)
  default     = []
}

variable "deletion_protection" {
  type        = bool
  description = "(Optional) A value that indicates whether the DB cluster has deletion protection enabled"
  default     = true
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether IAM database authentication is enabled"
  type        = bool
}

variable "s3_bucket" {
  description = "The ID of the Serverless code Bucket"
  type        = string
  default = null
}

variable "create_org_catalog_bucket" {
  description = "Controls bucket to be created"
  type        = bool
  default     = false
}

variable "create_org_catalog_s3_object" {
  description = "Object creation"
  type        = bool
  default     = false
}

variable "org_cat_fm_glue_script_location" {
  description = "The org catalog fm Glue script location"
  type        = string
  default     = ""
}

variable "org_cat_data_access_fm_glue_script_location" {
  description = "The org catalog data access fm Glue script location"
  type        = string
  default     = ""
}

variable "org_cat_download_glue_script_location" {
  description = "The org catalog download Glue script location"
  type        = string
  default     = ""
}

# Enclave Specific Resources
variable "enclave_specific_resource" {
  description = "Enclave Specific Resource Flag"
  type        = bool
  default     = false
}

variable "enclave_specific_ingest_glue_script_location" {
  description = "Enclave Specific Ingest Glue script location"
  type        = string
  default     = ""
}

variable "stream_poller_additional_params" {
  type        = map(string)
  description = "Additional parameters for stream poller lambda."
  default = {
    "NumberOfShards"          = "5"
    "NumberOfReplica"         = "1"
    "IgnoreMissingDocument"   = "true"
    "ReplicationScope"        = "all"
    "GeoLocationFields"       = ""
    "DatatypesToExclude"      = ""
    "PropertiesToExclude"     = ""
    "EnableNonStringIndexing" = "true"
  }
}

variable "create_neptune_poller_table" {
  description = "Neptune Poller Table creation"
  type        = bool
  default     = true
}

variable "create_imgviewer_infra" {
  description = "create infra for image viewer"
  type        = bool
  default     = false
}

variable "create_org_catalog" {
  description = "create infra for org catalog"
  type        = bool
  default     = false
}

variable "use_endor_data_domain" {
  description = "create infra for endor data domain ingestion"
  type        = bool
  default     = false
}

variable "datasync_crossaccount_role" {
  description = "datasync role for cross account"
  type = string
  default = ""
}

variable "create_pagination_infra" {
  description = "create infra for pagination"
  type        = bool
  default     = false
}

#Cost Dashboard Changes
variable "enable_budget" {
  description = " Flag to enable/disable budget"
  type    = bool
  default = true
}