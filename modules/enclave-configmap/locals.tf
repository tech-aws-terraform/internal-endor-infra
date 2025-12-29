locals {
  region_name       = split("-", var.enclave_region)
  region_short_name = format("%s%s%s", local.region_name[0], substr(local.region_name[1], 0, 1), substr(local.region_name[2], 0, 1))
  resource_prefix   = "${var.environment}-${local.region_short_name}"
  name              = "${local.resource_prefix}-${var.enclave_key}-cluster"
}