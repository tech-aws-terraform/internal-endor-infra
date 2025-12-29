variable "compute_inst_type" {
  type    = string
  default = "FARGATE"
}


variable "compute_env_name" {
  type    = string
  default = ""
}

variable "subnet_ids" {
  type    = list(string)
  default = []
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "batch_service_role_arn" {
  type    = string
  default = ""
}

variable "max_vcpus" {
  type    = number
  default = 4
}

variable "job_def_name" {
  type    = string
  default = ""
}


variable "job_inst_type" {
  type    = string
  default = ""
}



variable "platform_capabilities" {
  type    = list(string)
  default = []
}

variable "container_properties" {
  type    = string
  default = ""
}

variable "create_job_def" {
  type    = bool
  default = false
}
variable "create_job_queue" {
  type    = bool
  default = false
}

variable "job_queue_name" {
  type    = string
  default = ""
}

variable "queue_state" {
  type    = string
  default = "ENABLED"
}

variable "priority" {
  type    = number
  default = 0

}

variable "tags" {
  type        = map(string)
  description = "Mapping of Tags"
  default     = {}
}

variable "compute_env_count" {
  type    = number
  default = 0
}