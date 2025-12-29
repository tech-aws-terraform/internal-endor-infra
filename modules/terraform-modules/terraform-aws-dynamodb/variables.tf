variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "Endor environment"
  type        = string
}

variable "dynamodb_tbl_name" {
  description = "PTFM Table Name"
  type        = string
}

variable "point_in_time_recovery_enabled" {
  description = "Flag for creating PITR"
  type        = bool
  default     = true
}

variable "create_metadata_table" {
  description = "Create Metadata Table"
  type        = bool
  default     = false
}

variable "create_neptune_poller_table" {
  description = "Create Neptune Opensearch Poller Table"
  type        = bool
  default     = false
}

variable "neptune_opensearch_stream_application_name" {
  description = "Neptune Opensearch Stream Application Name"
  type        = string
  default = ""
}