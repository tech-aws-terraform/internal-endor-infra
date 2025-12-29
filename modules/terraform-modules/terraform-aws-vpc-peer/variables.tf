variable "requester_vpc_id" {
  description = "Requester VPC ID"
  type        = string
}

variable "accepter_vpc_id" {
  description = "Accepter VPC ID"
  type        = string
}

variable "accepter_owner_id" {
  description = "Accepter Owner ID"
  type        = string
}

variable "accepter_region" {
  description = "Accepter Region"
  type        = string
}

variable "tags" {
  description = "Mapping of Tags of S3 Bucket"
  type        = map
  default     = {}
}

variable "requester_pvt_rt" {
  description = "Requester Private Route Table ID"
  type        = string
}

variable "accepter_cidr" {
  description = "Accepter CIDR"
  type        = string
}