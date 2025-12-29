variable "transfer_secured_waf_name" {
  description = "Name of the WAF"
  type        = string
  default     = ""
}

variable "transfer_secured_metric_name" {
  description = "Metric of the WAF"
  type        = string
  default     = ""
}

variable "scope" {
  description = "Scope of the WAF"
  type        = string
  default     = "REGIONAL"
}

variable "tags" {
  type        = map
  description = "Mapping of Tags of WAF"
  default     = {}
}

variable "regex_pattern_str" {
  description = "Regex Patern String to Match the Rule"
  type        = string
  default     = "^[a-zA-Z0-9+/_.-]+%40[a-zA-Z0-9.-]"
}

variable "transfer_secure_api_stage_arn" {
  description = "API GATEWAY stage ARN"
  type        = string
  default     = ""
}