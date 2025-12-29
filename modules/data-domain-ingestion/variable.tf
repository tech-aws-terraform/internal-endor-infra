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

variable "ingest_bucket_id" {
  type        = string
  description = "ingest S3 bucket id"
}

variable "ingest_bucket_arn" {
  type        = string
  description = "ingest S3 bucket arn"
}

variable "use_endor_data_domain" {
  description = "create infra for endor data domain ingestion"
  type        = bool
  default     = false
}

variable "endor_api_base_url" {
  description = "API Base endpoint URL for data domain ingestion"
  type        = string
  default     = ""
}

variable "data_domain_vpc_id" {
  type        = string
  description = "Existing VPC ID created for Endor data doamin ingestion"
  default     = ""
}

variable "data_domain_vpc_cidr" {
  type        = string
  description = "VPC CIDR block ID for Endor data domain "
  default     = ""
}

variable "data_domain_subnet_id" {
  type        = string
  description = "Subnet ID for Endor data domain Ingestion (Appserver subnet id)"
  default     = ""
}

#### Varaibles for ECR docker IMAGE url creation from devops account ###
variable "devops_account_id" {
  description = "Account id for ECR"
  type        = string
  default     = "195227247767"
}


variable "batch_job_docker_img_name" {
  description = "docker image name for batch job"
  type        = string
  default     = "data-domain-batch"
}

variable "devops_region" {
  description = "Devops account region"
  type        = string
  default     = "eu-central-1"
}

# variable "batch_job_ecr_repo_name"{
#   type = string
#   description = "ECR Repo name for batch job"
#   default = "internal-enclave-serverless-repository"
# }

variable "batch_job_ecr_image_tag" {
  type        = string
  description = "Tag for batch job (python code) docker image created in the devops account"
  default     = ""
}

############################

variable "ingest_status_sqs_queue_id" {
  type        = string
  description = "endor SQS queue url to send file movement status msg"
  default     = ""
}

variable "ingest_status_sqs_arn" {
  type        = string
  description = "endor SQS queue arn to send file movement status msg"
  default     = ""
}

variable "create_batch_service_role" {
  type = bool
  description = "Create service linked role for Batch (Created one time in an account)"
  default = false
}

variable "data_domain_ingest_bucket" {
  type= string
  description = "Endor data domain ingest bucket"
  default = ""
}

variable "endor_catalog_table_name" {
  type = string
  description = "Endor dynamo db name for catalog table"
  default = ""
}

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

variable "prestage_bucket_id" {
  type = string
  description = "prestage S3 bucket id"
}

variable "transfer_lambda_arn" {
  type = string
  description = "Transfer lambda arn"
}