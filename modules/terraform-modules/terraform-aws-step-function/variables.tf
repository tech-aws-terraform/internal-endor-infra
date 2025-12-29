variable "neptune_opensearch_poller_state_machine_name" {
  description = "Neptune Opensearch Stream State Machine Name"
  type        = string
  default     = ""
}

variable "neptune_opensearch_poller_state_machine_iam_arn" {
  description = "Neptune Opensearch Stream State Machine Name IAM Role ARN"
  type        = string
  default     = ""
}

variable "neptune_duplicate_lambda_execution_check_funtion_arn" {
  description = "Check for lambda poller duplicate execution lambda ARN"
  type        = string
  default     = ""
}

variable "neptune_restart_state_machine_funtion_arn" {
  description = "Restart Neptune stream poller state machine lambda ARN"
  type        = string
  default     = ""
}

variable "neptune_opensearch_stream_poller_funtion_arn" {
  description = "Neptune Opensearch Stream Poller Lambda Function ARN"
  type        = string
  default     = ""
}

variable "tags" {
    description = "map of the oss tags "
    type        = map
    default     = {}
}