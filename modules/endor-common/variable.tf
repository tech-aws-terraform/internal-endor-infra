variable "create_batch_service_role" {
  type = bool
  description = "Create service linked role for Batch (Created one time in an account)"
  default = false
}

variable "enclave_key" {
  description = "The enclave id"
  type        = string
}

variable "enclave_region" {
  description = "The enclave region"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

#Cost Dashboard Changes
variable "enable_cur_report" {
  description = " Flag to enable/disable for cost and usage reports"
  type    = bool
  default = false
}

variable "cost_bucket_replication" {
  description = " Flag to enable/disable S3 bucket replication for cost and usage reports"
  type    = bool
  default = false
}

variable "platform_account_cost_bucket" {
  description = "The name of the S3 bucket used for storing cost reports in the platform account"
  type        = string
  default     = ""
}

variable "platform_account_id" {
  description = "The AWS account ID of the platform account"
  type        = string
  default     = ""
}

variable "enclave_account_id" {
  description = "Enclave Account ID"
  type        = string
  default     = ""
}