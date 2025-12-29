variable "environment" {
  description = "Environment name"
  type        = string
}

variable "enclave_key" {
  description = "The enclave id"
  type        = string
}

variable "enclave_region" {
  description = "The enclave region"
  type        = string
}

# Auto-generated variables for config_map.tf
variable "endor_prestaging_bucket" {
  description = "S3 bucket for pre-staging data."
  type        = string
}

variable "endor_staging_bucket" {
  description = "S3 bucket for staging data."
  type        = string
}

variable "endor_ingest_bucket" {
  description = "S3 bucket for ingest data."
  type        = string
}

variable "endor_study_scientific_bucket" {
  description = "S3 bucket for scientific study data."
  type        = string
}

variable "endor_study_supportive_bucket" {
  description = "S3 bucket for supportive study data."
  type        = string
}

variable "data_ingestion_queue" {
  description = "SQS queue for data ingestion."
  type        = string
}

variable "endor_catalog_bucket" {
  description = "S3 bucket for catalog data."
  type        = string
}

variable "open_search_endpoint" {
  description = "Endpoint for OpenSearch."
  type        = string
}

variable "neptune_cluster_identifier" {
  description = "Neptune cluster id."
  type        = string
}

variable "neptune_write_endpoint" {
  description = "Neptune write endpoint."
  type        = string
}

variable "neptune_port" {
  description = "Port for Neptune database."
  type        = string
}

variable "neptune_iam_role_arn" {
  description = "IAM Role ARN for Neptune."
  type        = string
}

variable "neptune_assume_role_arn" {
  description = "Assume Role ARN for Neptune."
  type        = string
}

variable "neptune_assume_role_name" {
  description = "Assume Role Name for Neptune."
  type        = string
}

variable "platform_navify_endpoint" {
  description = "Endpoint for Platform Navify."
  type        = string
}

variable "endor_rest_api_hostname" {
  description = "Hostname for Endor REST API."
  type        = string
}

variable "sentieon_service_name" {
  description = "Service name for Sentieon."
  type        = string
}

variable "oidcScope" {
  description = "OIDC scope value"
  type        = string
  default     = "default email navify:tenant:kamino-platform-tenant-dev profile"
}

variable "platform_region" {
  description = "Platform region"
  type        = string
  default     = "eu-central-1"
}

variable "platform_secret_arn" {
  description = "Platform secret ARN"
  type        = string
  default     = "arn:aws:secretsmanager:eu-central-1:730335264630:secret:dev-euc1-platform-app-navify-oidc-secrets-sW2gCc"
}

variable "platform_account_id" {
  description = "Platform account ID"
  type        = string
  default     = "730335264630"
}

variable "platform_domain_api_name" {
  description = "Platform domain API name"
  type        = string
  default     = "https://api.platform.kamino-dev.platform.navify.com"
}

variable "nft_bucket_id" {
  description = "NFT bucket ID"
  type        = string
  default     = "dev-usw2-mandalore-sagemaker-output-s3"
}

variable "nft_ec2_enclave_role_arn" {
  description = "NFT EC2 enclave role ARN"
  type        = string
  default     = "arn:aws:iam::730335264630:role/kamino-eu-central-1-nextflow-ec2-role"
}

variable "nft_domain_name" {
  description = "NFT domain name"
  type        = string
  default     = "https://nft.platform.kamino-dev.platform.navify.com"
}

variable "nft_batch_enclave_role_arn" {
  description = "NFT batch enclave role ARN"
  type        = string
  default     = "arn:aws:iam::058264342729:role/dev-usw2-mandalore-nftower-batch-role"
}

variable "use_endor_data_domain" {
  description = "Whether to use Endor data domain"
  type        = string
  default     = "true"
}

variable "endor_catalog_table_sqs_listener" {
  description = "Endor catalog table SQS listener"
  type        = string
  default     = "https://sqs.us-west-2.amazonaws.com/687979975259/dev-usw2-internal-enclave-ingest-feedback-queue"
}

variable "endor_event_bridge_pipe_name" {
  description = "Endor Event Bridge pipe name"
  type        = string
  default     = "dev-usw2-internal-enclave-ingest-feedback-event-pipe"
}

variable "endor_account_id" {
  description = "Endor account ID"
  type        = string
  default     = "687979975259"
}

variable "event_bridge_pipe_role_arn" {
  description = "Event Bridge pipe role ARN"
  type        = string
  default     = "arn:aws:iam::687979975259:role/dev-usw2-internal-enclave-ingest-feedback-event-pipe-role"
}

variable "cross_account_arn" {
  description = "Cross account ARN"
  type        = string
  default     = "arn:aws:iam::687979975259:role/mass-spec-s3-cross-account-access"
}

variable "day_of_file_delete_first_reminder_email" {
  description = "Day of file delete first reminder email"
  type        = string
  default     = "6"
}

variable "day_of_file_delete_second_reminder_email" {
  description = "Day of file delete second reminder email"
  type        = string
  default     = "5"
}

variable "endor_budget_role_arn" {
  description = "The ARN of the Budget Role"
  type        = string
}
