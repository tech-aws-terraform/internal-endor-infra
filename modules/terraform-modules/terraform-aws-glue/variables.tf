variable "glue_job_name" {
  description = "The name you assign to this job. It must be unique in your account"
  type = string
  default = ""
}

variable "role_arn" {
  description = "The ARN of the IAM role associated with this job"
  type = string
  default = ""
}

variable "max_capacity" {
  description = "The maximum number of AWS Glue data processing units (DPUs) that can be allocated when this job runs"
  type = number
  default = 1.0
}

variable "command_name" {
  description = "The name of the job command. Defaults to glueetl"
  type = string
  default = "glueetl"
}

variable "python_version" {
  description = "The Python version being used to execute a Python shell job. Allowed values are 2 or 3."
  type = number
  default = 3.9
}

variable "script_location" {
  description = "The number of workers of a defined workerType that are allocated when a job runs"
  type        = string
  default     = ""
}

variable "sqs_url" {
  description = "SQS URL"
  type        = string
  default     = ""
}

variable "vpc_url" {
  description = "VPC URL"
  type        = string
  default     = ""
}

variable "max_concurrent_runs" {
  description = "Maximum Concurrent runs"
  type = number
  default = 20
}

variable "tags" {
  description = "Key-value map of resource tags"
  type = map(string)
  default = {}
}