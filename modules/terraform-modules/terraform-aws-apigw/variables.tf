variable "apigw_cw_role_arn" {
  description = "Name of the CW Role ARN"
  type        = string
  default     = ""
}

variable "apigw_rest_api_name" {
  description = "Name of the REST API"
  type        = string
  default     = ""
}

variable "endpoint_types" {
  description = "A list of endpoint types"
  type        = list(string)
  default     = ["REGIONAL"]
}

variable "tags" {
  type        = map
  description = "Mapping of Tags of WAF"
  default     = {}
}

variable "api_gw_stage_name" {
  description = " API Gateway stage Name"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "Deployment Region"
  type        = string
  default     = "eu-central-1"
}

variable "auth_lambda_arn" {
  description = "Auth Lambda ARN"
  type        = string
  default     = ""
}

variable "throttle_burst_lt" {
  description = " API Throttle Burst Limit"
  type        = number
  default     = 1000
}

variable "throttle_rate_lt" {
  description = " API Throttle Rate Limit"
  type        = number
  default     = 500
}

variable "logging_level" {
  description = "Logging Level"
  type        = string
  default     = "INFO"
}

variable "auth_lambda_func" {
  description = "Auth Lambda Function Name"
  type        = string
  default     = ""
}

variable "api_resource_path" {
  description = "API Gateway resource path"
  type        = string
  default     = "/*/GET/sftp-auth/servers/*/users/*/config"
}