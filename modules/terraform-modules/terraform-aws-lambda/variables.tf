variable "function_name" {
  description = "Lambda Function Name"
  type        = string
  default     = ""
}

variable "role_arn" {
  description = "Role ARN"
  type        = string
  default     = ""
}

variable "runtime" {
  description = "Runtime Language"
  type        = string
  default     = "python3.10"
}

variable "lambda_handler" {
  description = "Lambda Handler Name"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Valid value between 128 MB to 10,240 MB (10 GB), in 64 MB increments."
  type        = number
  default     = 10240
}

variable "timeout" {
  description = "Timeout"
  type        = number
  default     = 900
}

variable "description" {
  description = "Description of your Lambda Function (or Layer)"
  type        = string
  default     = ""
}

variable "tags" {
  type        = map
  description = "Mapping of Tags of S3 Bucket"
  default     = {}
}

variable "sqs_queue_id" {
  description = "SQS Queue ID"
  type        = string
  default     = ""
}

variable "vpc_url" {
  description = "VPC URL"
  type        = string
  default     = ""
}

variable "glue_job_name" {
  description = "Glue Job Name"
  type        = string
  default     = ""
}

variable "max_file_count" {
  description = "Max File Count"
  type        = number
  default     = 200
}

variable "max_file_size_in_gb" {
  description = "Max file size in GB"
  type        = number
  default     = 200
}

variable "region" {
  description = "The Region Name where AWS resources will be deployed"
  type        = string
  default     = ""
}

variable "api_domain" {
  description = "Enclave SFTP API domain"
  type        = string
  default     = ""
}

variable "action" {
  description = "Action"
  type        = string
  default     = ""
}

variable "principal" {
  description = "Principal"
  type        = string
  default     = ""
}

variable "source_arn" {
  description = "Source ARN"
  type        = string
  default     = ""
}

variable "region_short_name" {
  description = "Region Short Name"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev"
}

variable "enclave_id" {
  description = "Enclave ID"
  type        = string
  default     = ""
}

variable "destination_name_suffix" {
  description = "Destination Bucket Suffix"
  type        = string
  default     = ""
}

variable "neptune_opensearch_stream_application_name" {
  description = "Neptune Opensearch Stream Application Name"
  type        = string
  default     = ""
}

variable "neptune_opensearch_stream_lease_dynamo_table" {
  description = "Neptune Opensearch Stream Lease Dynamodb Table Name"
  type        = string
  default     = ""
}

variable "neptune_opensearch_stream_state_machine_name" {
  description = "Neptune Opensearch Stream Statemachine Name"
  type        = string
  default     = ""
}

variable "stream_poller_additional_params" {
  type        = map(string)
  description = "Additional parameters for stream poller lambda."
  default     = {}
}

variable "opensearch_endpoint" {
  description = "Opensearch Endpoint for Neptune Poller"
  type        = string
  default     = ""
}

variable "IAMAuthEnabledOnSourceStream" {
  description = "IAMAuthEnabledOnSourceStream"
  type        = bool
  default     = false
}

variable "LoggingLevel" {
  description = "LoggingLevel"
  type        = string
  default     = ""
}

variable "MaxPollingInterval" {
  description = "MaxPollingInterval"
  type        = number
  default     = 600
}

variable "MaxPollingWaitTime" {
  description = "MaxPollingWaitTime"
  type        = number
  default     = 60
}

variable "NeptuneStreamEndpoint" {
  description = "NeptuneStreamEndpoint"
  type        = string
  default     = ""
}

variable "StreamRecordsBatchSize" {
  description = "StreamRecordsBatchSize"
  type        = number
  default     = 100
}

variable "StreamRecordsHandler" {
  description = "StreamRecordsHandler"
  type        = string
  default     = ""
}

variable "OrgCatalogIndex" {
  description = "OrgCatalogIndex"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = []
}

variable "create_neptune_opensearch_stream_poller_funtion" {
  description = "Flag for creating Neptune Opensearch Stream Poller Lambda"
  type        = bool
  default     = false
}