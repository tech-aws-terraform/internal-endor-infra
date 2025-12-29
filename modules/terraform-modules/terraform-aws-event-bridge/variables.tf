variable "neptune_opensearch_stream_application_name" {
  description = "Neptune Opensearch Stream Application Name"
  type        = string
  default = ""
}

variable "neptune_stream_poller_state_machine_arn" {
  description = "Neptune Stream Poller State Machine ARN"
  type        = string
  default = ""
}

variable "neptune_poller_eventbridge_rule_execution_role_arn" {
  description = "Neptune Poller Eventbridge IAM Role ARN"
  type        = string
  default = ""
}

variable "tags" {
  type        = map(any)
  description = "Mapping of Tags of S3 Bucket"
  default     = {}
}

variable "neptune_stream_poller_event_bridge_iam_role_name" {
  description = "Role name for Neptune Opensearch Stream Poller Event Bridge"
  type        = string
  default     = ""
}

variable "neptune_stream_poller_event_bridge_policy_name" {
  description = "Policy name for Neptune Opensearch Stream Poller Event Bridge"
  type        = string
  default     = ""
}