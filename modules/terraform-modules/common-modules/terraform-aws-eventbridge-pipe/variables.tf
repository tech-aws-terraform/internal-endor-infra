variable "pipe_name" {
  type    = string
  default = ""
}

variable "assume_role_arn" {
  type    = string
  default = ""
}

variable "source_arn" {
  type    = string
  default = ""
}

variable "target_arn" {
  type    = string
  default = ""
}

variable "source_role_policy" {
  type    = string
  default = ""
}

variable "target_role_policy" {
  type    = string
  default = ""
}

variable "batch_size" {
  description = "The maximum number of records to include in each batch."
  type = number
  default = 1 
}


variable "step_func_invoc_type" {
  description = "Specify whether to invoke the function synchronously or asynchronously."
  type = string
  default = "FIRE_AND_FORGET"
}
