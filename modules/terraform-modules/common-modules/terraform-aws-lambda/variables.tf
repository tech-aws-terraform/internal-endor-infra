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
  default     = "python3.9"
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

#variable "ephermal_storage" {
#  type = number
#  default = 10240
#}

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
  type        = map(string)
  description = "Mapping of Tags"
  default     = {}
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

variable "lambda_dir" {
  description = "lambda dir"
  type        = string
  default     = ""
}

variable "layer_filename" {
  description = "lambda layer file name"
  type        = string
  default     = ""
}

variable "layer_name" {
  type    = string
  default = ""
}

variable "create_layer" {
  type        = bool
  description = "create lambda layer"
  default     = false
}

variable "env_vars" {
  type    = map(string)
  default = {}
}

variable "create_sqs_trigger" {
  type        = bool
  description = "create sqs trigger for lambda"
  default     = false
}

variable "sqs_queue_arn" {
  description = "Source SQS queue ARNv to trigger lambda"
  type        = string
  default     = ""
}

variable "num_concurrent_executions" {
  type = number
  description = " Defaults to Unreserved Concurrency Limits -1"
  default = -1
}

variable "additional_event_trigger" {
  type        = bool
  description = "create sqs trigger for lambda"
  default     = false
}

variable "additional_source_arn" {
  description = "Source arn for additonal event trigger for lambda"
  type        = list(string)
  default     = []
}

