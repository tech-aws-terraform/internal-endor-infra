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

variable "connections" {
  type = list(string)
  default = []
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


variable "max_concurrent_runs" {
  description = "Maximum Concurrent runs"
  type = number
  default = 0
}

variable "tags" {
  description = "Key-value map of resource tags"
  type = map(string)
  default = {}
}

variable "glue_version" {
  description = "Glue version"
  type = string
  default = "4.0"
}
variable "worker_type" {
  description = "Worker type"
  type = string
  default = ""
}

variable "timeout" {
  description = "time out"
  type = number
  default = 0
}
variable "no_of_workers" {
  type = number
  default = 0
}
variable "max_retries" {
  type = number
  default = 0
}

variable "env_vars" {
  type    = map(string)
  default = {}
}