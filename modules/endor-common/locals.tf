locals {
  region_name                 = split("-", var.enclave_region)
  region_short_name           = format("%s%s%s", local.region_name[0], substr(local.region_name[1], 0, 1), substr(local.region_name[2], 0, 1))
  key                         = lower("${var.enclave_key}")
  key_with_underscore         = replace(local.key, "-", "_")

  tags = merge(
    {
      "Enclave"   = "${var.enclave_key}"
    },
  )

  # Check if the input contains any hyphens
  contains_hyphen = can(regex("-", var.enclave_key))
  
  # Split the input string into a list of words if it contains a hyphen
  enclave = local.contains_hyphen ? split("-", var.enclave_key) : []
  
  # Extract the first letter of each word and join them if there are multiple words
  enclave_short_key = local.contains_hyphen ? join("", [for word in local.enclave : substr(word, 0, 1)]) : null
  
  # Cost Dashboard Changes
  resource_prefix   = "${var.environment}-${local.region_short_name}"
}