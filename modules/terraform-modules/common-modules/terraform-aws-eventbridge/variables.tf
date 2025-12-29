variable "description" {
  type        = string
  description = "event rule desc"
  default     = "event rule to filter based on condition"
}
variable "event_rule_name" {
  type        = string
  description = "event rue name for img processing"
  default     = ""
}

variable "target_arn" {
  description = "target arn"
  type        = string
  default     = ""
}

variable "event_target_id" {
  description = "event target"
  type        = string
  default     = ""
}

variable "event_rule_pattern" {
  description = "event pattern for rule"
  type        = any
}

variable "tags" {
  type        = map(any)
  description = "Mapping of Tags"
  default     = {}
}

variable "event_rule_role_arn" {
  type = string
  default = ""
}