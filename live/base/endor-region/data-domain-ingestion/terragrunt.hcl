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
  data_domain_ingest_bucket = local.global_vars.locals.data_domain_ingest_bucket
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../modules//data-domain-ingestion"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}


dependency "infra" {
  config_path = "../endor-infra"

  mock_outputs = {
    sqs_queue_id    = "https://sqs.us-west-2.amazonaws.com/687979975259/internal-enclave-sqs"
    sqs_queue_arn   = "arn:aws:sqs:us-west-2:687979975259:internal-enclave-sqs"
    ingest_s3_bucket_id  = "dev-usw2-internal-enclave-ingest-s3"
    ingest_s3_bucket_arn = "arn:aws:s3:::dev-usw2-internal-enclave-ingest-s3"
    transfer_lambda_arn    = "arn:aws:lambda:eu-central-1:058264342729:function:stepfn-wait-lambda"
    prestage_s3_bucket_id  = "dev-usw2-roche-internal-test-prestaging-s3"
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
  use_endor_data_domain    = local.global_vars.locals.use_endor_data_domain
  ingest_bucket_id         = dependency.infra.outputs.ingest_s3_bucket_id
  ingest_bucket_arn        = dependency.infra.outputs.ingest_s3_bucket_arn
  ingest_status_sqs_queue_id = dependency.infra.outputs.sqs_queue_id
  ingest_status_sqs_arn      = dependency.infra.outputs.sqs_queue_arn
  endor_api_base_url = local.global_vars.locals.endor_api_base_url
	data_domain_vpc_id = local.global_vars.locals.data_domain_vpc_id
	data_domain_vpc_cidr = local.global_vars.locals.data_domain_vpc_cidr
	data_domain_subnet_id = local.global_vars.locals.data_domain_subnet_id
	batch_job_ecr_image_tag = local.global_vars.locals.batch_job_ecr_image_tag

  data_domain_ingest_bucket = local.data_domain_ingest_bucket
  enclave_engg_role             = local.global_vars.locals.enclave_engg_role
  enclave_devops_role           = local.global_vars.locals.enclave_devops_role
  endor_catalog_table_name      = local.global_vars.locals.endor_catalog_table_name
  datasync_crossaccount_role    = local.global_vars.locals.datasync_crossaccount_role
  prestage_bucket_id       = dependency.infra.outputs.prestage_s3_bucket_id
  transfer_lambda_arn      = dependency.infra.outputs.transfer_lambda_arn
}