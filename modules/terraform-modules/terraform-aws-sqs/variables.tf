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

variable "endor_account_id" {
  description = "Endor Account ID"
  type        = string
  default     = ""
}

variable "enclave_trust_iam_roles" {
  description = "Enclave TrustRelationShip Roles"
  type        = list(string)
  default     = []
}