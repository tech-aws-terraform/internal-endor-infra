variable "oss_collection_name" {
  description = "Open search serverless collection Name "
  type        = string
}

variable "oss_collection_standby_replicas" {
  description = "Indicates whether standby replicas should be used for a collection."
  type        = string
  default     = "DISABLED"
}

variable "oss_collection_type" {
  description = "Open search serverless collection type "
  type        = string
  default     = "SEARCH"
}

variable "oss_security_encryption_policy_name" {
  description = "Open search serverless security encryption policy Name "
  type        = string
  default     = "oss-encyption"
}

variable "oss_security_network_policy_vpc_access_name" {
  description = "Open search serverless security network policy Name "
  type        = string
  default     = "oss-network"
}

variable "oss_data_access_policy_name" {
  description = "Open search serverless data access policy Name "
  type        = string
  default     = "oss-access-policy"
}

variable "tags" {
    description = "map of the oss tags "
    type        = map
    default     = {}
}


/*variable "source_vpce_list" {
  description = "list of source VPCEs "
  type        = list(string)
}*/

variable "enable_dashboard_access" {
  description = "A boolean flag to enable or disable dashboard access"
  type        = bool
  default     = false
}

variable "region" {
  description = "Region"
  type        = string
  default     = "eu-central-1"
}

variable "enclave_key" {
  description = "The enclave id"
  type        = string
}

variable "oss_vpc_endpoint_name" {
  description = "Oss VPC Endpoint Name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet ids"
  type        = list(string)
}

variable "vpc_security_group" {
  description = "VPC security Group"
  type        = string
}

variable "neptune_opensearch_stream_poller_funtion_arn" {
  description = "Neptune Poller Lambda Function ARN"
  type        = string
  default = ""
}

variable "principal" {
  description = "List of IAM roles for data access principal"
  type        = list(string)
}
