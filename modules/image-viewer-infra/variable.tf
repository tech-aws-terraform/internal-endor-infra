variable "enclave_key" {
  description = "The enclave id"
  type        = string
}

variable "enclave_region" {
  description = "The enclave region"
  type        = string
}

variable "endor_account_id" {
  description = "Environment"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "enclave_account_id" {
  description = "Environment"
  type        = string
}

variable "create_image_infra" {
  type        = bool
  description = "create infra for thumbnail image workflow"
  default     = false
}

variable "glue_python_version" {
  type = string
  default = "3"
}

variable "max_glue_concurrent_runs" {
  type = number
  default = 20
}

variable "img_glue_script_location" {
  type = string
  default = ""
}

variable "worker_type" {
  description = "Worker type"
  type = string
  default = "G.8X"
}

variable "timeout" {
  description = "time out"
  type = number
  default = 3600 #2880
}

variable "no_of_workers" {
  type = number
  default = 20
}


variable "max_retries" {
  type = number
  default = 3
}

variable "thumb_img_width" {
  type = string
  default = "500"
}

variable "thumb_img_height" {
  type = string
  default = "500"
}

variable "max_size_toinvoke_glue" {
  type = string
  default = "5"
}

# variable "spark_s3_logs_path" {
#   type = string
#   description = "Write Spark UI logs to Amazon S3"
#   default = ""
# }

variable "prestage_bucket_id" {
  type = string
  description = "prestage S3 bucket id"
}

variable "prestage_bucket_arn" {
  type = string
  description = "prestage S3 bucket arn"
}

variable "transfer_lambda_arn" {
  type = string
  description = "Transfer lambda arn"
}

variable "glue_job_iam_role_arn" {
  type = string
  description = "Glue role arn"
}

variable "ingest_bucket_id" {
  type        = string
  description = "ingest S3 bucket id"
}

# variable "create_endor_thumbimg_infra" {
#   type        = bool
#   description = "create endor infra for thumbnail image creation - only eventrule with cross account access to SQS"
#   default     = false
# }