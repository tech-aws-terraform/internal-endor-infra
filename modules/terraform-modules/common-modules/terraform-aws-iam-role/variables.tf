variable "role_name" {
  description = "Role name"
  type        = string
  default     = ""
}

variable "policy_name" {
  description = "Policy name"
  type        = string
  default     = ""
}

variable "log_account_arn" {
  description = "Account Log ARN"
  type        = string
  default     = ""
}

variable "log_account_lambda_arn" {
  description = "Account Log ARN with Lambda Function"
  type        = string
  default     = ""
}

variable "assume_role_policy" {
  type = string
  default = ""
}

variable "policy" {
  description = "policy"
  type        = string
  default     = ""
}

variable "role_max_session_duration" {
  description = "Maximum session duration (in seconds) that you want to set for the specified role"
  type        = string
  default     = "43200"
}

variable "tags" {
  type        = map(any)
  description = "Mapping of Tags "
  default     = {}
}

variable "attach_exist_policies" {
  type = list(string)
  default = []
  
}

variable "create_service_role" {
  type = number
  default  = 0
}

variable "aws_service_name" {
  type = string
  default = ""
}

variable "service_role_desc" {
  type = string
  default = ""
}

