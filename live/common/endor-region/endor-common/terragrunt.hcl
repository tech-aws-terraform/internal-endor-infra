locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  global_vars      = read_terragrunt_config(find_in_parent_folders("globals.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract out common variables for reuse
  environment         = local.global_vars.locals.environment
  enclave_name        = local.global_vars.locals.enclave_name
  enclave_account_id  = local.global_vars.locals.enclave_account_id
  endor_account_id    = local.global_vars.locals.endor_account_id
  enclave_domain_name = local.global_vars.locals.enclave_domain_name
  aws_region          = local.region_vars.locals.aws_region
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../modules//endor-common"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  create_batch_service_role           = local.global_vars.locals.create_batch_service_role
  enclave_key                         = local.enclave_name
  enclave_region                      = local.aws_region
  environment                         = local.environment
   # Cost Dashboard Resources
  enable_cur_report                   = local.global_vars.locals.enable_cur_report
  cost_bucket_replication             = local.global_vars.locals.cost_bucket_replication
  platform_account_cost_bucket        = local.global_vars.locals.platform_account_cost_bucket
  platform_account_id                 = local.global_vars.locals.platform_account_id
  enable_budget                       = local.global_vars.locals.enable_budget
  enclave_account_id                  = local.global_vars.locals.enclave_account_id
  enclave_engg_role                   = local.global_vars.locals.enclave_engg_role
  enclave_devops_role                 = local.global_vars.locals.enclave_devops_role
}