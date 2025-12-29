variable "state_machine_name" {
  type        = string
  description = "Name of the state machine"  
}

variable "state_machine_definition" {
  type = string
  description = "State machine template definition"
}

variable "state_machine_role_arn" {
  type = string
  description = "ARN of the IAM role for state machine"
}