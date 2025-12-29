variable "sqs_queue_name" {
  description = "SQS Queue Name"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Mapping of Tags of S3 Bucket"
  type        = map
  default     = {}
}

variable "policy" {
  description = "policy"
  type        = string
  default     = ""
}

variable "sqs_visibility_timeout" {
  description = "Queue visibility timeout"
  type        = number
  default     = 30
}