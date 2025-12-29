variable "create_bucket" {
  description = "Create bucket flag"
  type        = bool
  default     = false
}

variable "create_bucket_object" {
  description = "Create bucket flag"
  type        = bool
  default     = false
}

variable "s3_bucket_name" {
  description = "S3 Bucket Name"
  type        = string
  default     = ""
}

variable "force_destroy" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Mapping of Tags of S3 Bucket"
  type        = map
  default     = {}
}

variable "create_bucket_lc" {
  description = "Create bucket LC flag"
  type        = bool
  default     = false
}

variable "acl" {
  type        = string
  description = "Canned ACL of S3 Bucket"
  default     = "private"
}

variable "content_type" {
  type        = string
  description = "Content type of the S3 object"
  default     = "application/x-directory"
}

variable "create_bucket_notification" {
  description = "Create bucket notification flag"
  type        = bool
  default     = false
}

variable "lambda_function_arn" {
  description = "Approval Lambda ARN"
  type        = string
  default     = ""
}

variable "event_notification_prefix" {
  description = "event notification prefix"
  type        = string
  default     = ""
}

variable "event_notification_suffix" {
  description = "event notification suffix"
  type        = string
  default     = ""
}

variable "create_prestage_bucket_policy" {
  description = "Create prestage bucket policy flag"
  type        = bool
  default     = false
}

variable "create_stage_bucket_policy" {
  description = "Create stage bucket policy flag"
  type        = bool
  default     = false
}

variable "create_cors_policy" {
  description = "Create bucket cors policy flag"
  type        = bool
  default     = false
}

variable "policy" {
  description = "Bucket policy"
  type        = any
  default     = ""
}

variable "enclave_trust_iam_roles" {
  description = "Enclave TrustRelationShip Roles"
  type        = list(string)
  default     = []
}

variable "enclave_root_trust_iam_roles" {
  description = "Enclave TrustRelationShip Roles with root user"
  type        = list(string)
  default     = []
}

variable "s3_cors_origins" {
  description = "S3 Bucket CORS Origins"
  type        = list(string)
  default     = []
}

variable "create_study_sci_bucket_policy" {
  description = "Create study scientific ingressed data policy flag"
  type        = bool
  default     = false
}

variable "enclave_root_iam_role" {
  description = "Enclave Root IAM Role"
  type        = list(string)
  default     = []
}

variable "create_study_sup_bucket_policy" {
  description = "Create study supportive data policy flag"
  type        = bool
  default     = false
}

# variable "ignore_lifecycle_rules"{
#   description = "life cycle rule"
#   type        = list(string)
#   default     = []
# }

variable "bucket_lc_rule" {
  description = "Map of S3 lifecycle rules"
  type        = list(object({
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
      id                                 = "default"
      enabled                            = true
      prefix                             = ""
      tags                               = {}
      expiration_days                    = 30
      expired_object_delete_marker       = false
      noncurrent_version_expiration_days = 30
    }
  ]
}

variable "prestaging_bucket_lc_rule" {
  description = "Map of S3 lifecycle rules"
  type        = list(object({
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
      id                                 = "default"
      enabled                            = true
      prefix                             = ""
      tags                               = {}
      expiration_days                    = 30
      expired_object_delete_marker       = false
      noncurrent_version_expiration_days = 30
    }
  ]
}

variable "create_bucket_ownership" {
  description = "Create bucket ownership flag"
  type        = bool
  default     = false
}

variable "object_ownership" {
  description = "Object Ownership"
  type        = string
  default     = "BucketOwnerEnforced"
}

variable "create_bucket_versioning" {
  description = "Create bucket versioning flag"
  type        = bool
  default     = false
}

variable "versioning" {
  description = "Versioning"
  type        = string
  default     = "Disabled"
}

variable "s3_encryption_type" {
  description = "You may specify managed as encyption type for customer managed KMS key to use for encrypting our data at rest. If no key is specified, an AWS managed KMS ('aws/s3' managed service) key will be used for encrypting the data at rest."
  type        = string
  default     = "default"
}

variable "kms_key_arn" {
  description = "KMS Key ARN"
  type        = string
  default     = ""
}

variable "create_org_catalog_bucket_policy" {
  description = "Create Org Bucket Policy"
  type        = bool
  default     = false
}

variable "enclave_account_id" {
  description = "Enclave Account ID"
  type        = string
}

variable "create_org_cat_bucket_notification" {
  description = "Create Org Catalog bucket Notification flag"
  type        = bool
  default     = false
}

variable "org_catalog_fm_lambda_function_arn" {
  type        = string
  description = "Org Catalog File Movement Lambda ARN"
  default     = ""
}

variable "org_catalog_event_notification_prefix" {
  type        = string
  description = "Org Catalog event notification prefix"
  default     = "metadata/"
}

variable "org_catalog_event_notification_suffix" {
  type        = string
  description = "Org Catalog event notification suffix"
  default     = ".json"
}

variable "org_catalog_data_access_fm_lambda_function_arn" {
  type        = string
  description = "Org Catalog Data Access File Movement Lambda ARN"
  default     = ""
}

variable "org_catalog_data_access_event_notification_prefix" {
  type        = string
  description = "Org Catalog Data Access event notification prefix"
  default     = "dataAccess/"
}

variable "org_catalog_download_lambda_function_arn" {
  type        = string
  description = "Org Catalog File Movement Lambda ARN"
  default     = ""
}

variable "org_catalog_download_event_notification_prefix" {
  type        = string
  description = "Org Catalog Data Access event notification prefix"
  default     = "download/"
}

variable "enable_event_bridge" {
  type     = bool
  default  = false
}

variable "create_ingest_bucket_policy" {
  description = "create ingest bucket policy"
  type = bool
  default = false
}

variable "datasync_crossaccount_role" {
  description = "datasync role for cross account"
  type = string
  default = ""
}

variable "create_prestage_bucket_lc"{
  description = "create_prestage_bucket_life cycle rule"
  type = bool
  default = false
}