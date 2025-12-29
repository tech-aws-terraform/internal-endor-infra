variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  type        = bool
  default     = false
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "Neptune"
}

variable "vpc_endpoint_tags" {
  description = "A mapping of tags to assign to vpc S3 endpoint"
  type        = map(string)
  default     = {}
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "192.168.0.0/24"
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = ["192.168.0.0/26", "192.168.0.64/26"]
}

variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

variable "create_igw" {
  description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them."
  type        = bool
  default     = true
}

variable "igw_tags" {
  description = "Additional tags for the internet gateway"
  type        = map(string)
  default     = {}
}

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = map(string)
  default     = {}
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = true
}

variable "nat_eip_tags" {
  description = "Additional tags for the NAT EIP"
  type        = map(string)
  default     = {}
}

variable "nat_gateway_tags" {
  description = "Additional tags for the NAT gateways"
  type        = map(string)
  default     = {}
}

variable "neptune_subnets" {
  description = "A list of neptune subnets inside the VPC"
  type        = list(string)
  default     = ["192.168.0.128/26", "192.168.0.192/26"]
}

variable "neptune_subnet_tags" {
  description = "Additional tags for the neptune subnets"
  type        = map(string)
  default     = {}
}

variable "private_route_table_tags" {
  description = "A mapping of tags to assign to private route table"
  type        = map(string)
  default     = {}
}

variable "enable_s3_endpoint" {
  description = "Whether or not to enable S3 endpoint for the VPC"
  type        = bool
  default     = true
}

variable "create_org_catalog_sg" {
  description = "Whether or not to enable Org Catalog Security Group"
  type        = bool
  default     = true
}

variable "enclave_key" {
  description = "The enclave id"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
  default     = "eu-central-1"
}