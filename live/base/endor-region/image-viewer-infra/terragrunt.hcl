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
  source = "../../../../modules//image-viewer-infra"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}


dependency "infra" {
  config_path = "../endor-infra"

  mock_outputs = {
    transfer_lambda_arn    = "arn:aws:lambda:eu-central-1:058264342729:function:stepfn-wait-lambda"
    prestage_s3_bucket_id  = "dev-usw2-roche-internal-test-prestaging-s3"
    prestage_s3_bucket_arn = "arn:aws:s3:::dev-usw2-roche-internal-prestaging-s3"
    glue_job_iam_role_arn  = "arn:aws:lambda:eu-central-1:058264342729:function:dev-usw2-roche-internal-enclave-endor-glue-role"
    ingest_s3_bucket_id  = "dev-usw2-internal-enclave-ingest-s3"
    ingest_s3_bucket_arn = "arn:aws:s3:::dev-usw2-internal-enclave-ingest-s3"
  }

  mock_outputs_merge_strategy_with_state = "shallow"
}


# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  enclave_key              = local.enclave_name
  enclave_region           = local.aws_region
  environment              = local.environment
  enclave_account_id       = local.enclave_account_id
  endor_account_id         = local.endor_account_id
  enclave_domain_name      = local.enclave_domain_name
  create_image_infra       = local.global_vars.locals.create_image_infra
  img_glue_script_location = local.environment_vars.locals.img_glue_script_location
  prestage_bucket_id       = dependency.infra.outputs.prestage_s3_bucket_id
  prestage_bucket_arn      = dependency.infra.outputs.prestage_s3_bucket_arn
  transfer_lambda_arn      = dependency.infra.outputs.transfer_lambda_arn
  glue_job_iam_role_arn    = dependency.infra.outputs.glue_job_iam_role_arn
  ingest_bucket_id         = dependency.infra.outputs.ingest_s3_bucket_id
  ingest_bucket_arn        = dependency.infra.outputs.ingest_s3_bucket_arn
  #create_endor_thumbimg_infra       = local.global_vars.locals.create_endor_thumbimg_infra
}