locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  global_vars      = read_terragrunt_config(find_in_parent_folders("globals.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract out common variables for reuse
  environment                   = local.global_vars.locals.environment
  enclave_name                  = local.global_vars.locals.enclave_name
  enclave_account_id            = local.global_vars.locals.enclave_account_id
  endor_account_id              = local.global_vars.locals.endor_account_id
  enclave_domain_name           = local.global_vars.locals.enclave_domain_name
  enclave_engg_role             = local.global_vars.locals.enclave_engg_role
  enclave_devops_role           = local.global_vars.locals.enclave_devops_role
  api_key_expires               = local.global_vars.locals.api_key_expires
  enclave_vpc_id                = local.global_vars.locals.enclave_vpc_id
  enclave_vpc_cidr              = local.global_vars.locals.enclave_vpc_cidr

  enclave_specific_resource     = local.global_vars.locals.enclave_specific_resource

  neptune_instance_count        = local.global_vars.locals.neptune_instance_count
  min_nep_capacity              = local.global_vars.locals.min_nep_capacity
  max_nep_capacity              = local.global_vars.locals.max_nep_capacity

  aws_region                    = local.region_vars.locals.aws_region

  platform                      = local.environment_vars.locals.platform
  # transfer_glue_script_location = local.environment_vars.locals.transfer_glue_script_location
  # approval_glue_script_location = local.environment_vars.locals.approval_glue_script_location
  # ingest_glue_script_location   = local.environment_vars.locals.ingest_glue_script_location

  enclave_specific_ingest_glue_script_location = local.environment_vars.locals.enclave_specific_ingest_glue_script_location

  org_cat_fm_glue_script_location             = local.environment_vars.locals.org_cat_fm_glue_script_location
  org_cat_data_access_fm_glue_script_location = local.environment_vars.locals.org_cat_data_access_fm_glue_script_location
  org_cat_download_glue_script_location       = local.environment_vars.locals.org_cat_download_glue_script_location
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../modules//endor-infra"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  enclave_key             = local.enclave_name
  enclave_region          = local.aws_region
  environment             = local.environment
  platform                = local.platform
  endor_account_id        = local.endor_account_id
  enclave_engg_role       = local.enclave_engg_role
  enclave_devops_role     = local.enclave_devops_role
  api_key_expires         = local.api_key_expires
  
  # Pre-requisite - The glue script should avaiable in the S3 bucket
  # transfer_glue_script_location  = local.transfer_glue_script_location
  # approval_glue_script_location  = local.approval_glue_script_location
  # ingest_glue_script_location    = local.ingest_glue_script_location

  org_cat_fm_glue_script_location             = local.org_cat_fm_glue_script_location
  org_cat_data_access_fm_glue_script_location = local.org_cat_data_access_fm_glue_script_location
  org_cat_download_glue_script_location       = local.org_cat_download_glue_script_location

  azs                            = local.region_vars.locals.azs

  enclave_account_id    = local.enclave_account_id
  enclave_domain_name   = local.enclave_domain_name

  #api_key_expires       = "2025-10-15T04:00:00Z"
  api_gw_stage_name     = local.environment

  accepter_cidr         = local.enclave_vpc_cidr
  accepter_vpc_id       = local.enclave_vpc_id

  cidr                  = "172.16.104.0/24"
  public_subnets        = ["172.16.104.0/26", "172.16.104.64/26"]
  neptune_subnets       = ["172.16.104.128/26", "172.16.104.192/26"]

#  deletion_protection   = false
#  enclave_domain_name   = "enclave-demo.kamino-dev.platform.navify.com"

  iam_database_authentication_enabled = true
  instance_count                      = local.neptune_instance_count
  min_nep_capacity                    = local.min_nep_capacity
  max_nep_capacity                    = local.max_nep_capacity

  enclave_base_vpc_cidr               = [local.enclave_vpc_cidr]

  # Enclave Specific Resources
  enclave_specific_resource                    = local.enclave_specific_resource
  enclave_specific_ingest_glue_script_location = local.enclave_specific_ingest_glue_script_location
  # image viewer flag
  create_imgviewer_infra                       = local.global_vars.locals.create_image_infra     
  create_org_catalog                           = local.global_vars.locals.create_org_catalog
  create_pagination_infra                      = local.global_vars.locals.create_pagination_infra
}