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
  aws_region                    = local.region_vars.locals.aws_region
  platform                      = local.environment_vars.locals.platform
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "../../../../modules//enclave-configmap"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}
# Include all dependency modules in this section
dependency "infra" {
  config_path = "../endor-infra"
  mock_outputs = {
    prestage_s3_bucket_id                   = "dev-usw2-internal-enclave-prestaging-s3"
    stage_s3_bucket_id                      = "dev-usw2-internal-enclave-staging-s3"
    ingest_s3_bucket_id                     = "dev-usw2-internal-enclave-ingest-s3"
    study_sci_ingress_data_s3_bucket_id     = "dev-usw2-internal-enclave-study-sci-ingress-data-s3"
    study_support_data_s3_bucket_name         = "dev-usw2-internal-enclave-study-supportive-data-s3"
    sqs_queue_id                              = "https://sqs.us-west-2.amazonaws.com/687979975259/internal-enclave-sqs"
    org_catalog_bucket_s3_bucket_id           = "dev-usw2-internal-enclave-org-catalog-s3"
    open_search_endpoint                      = "https://7f52tycdjv3b6hvh3ut8.us-west-2.aoss.amazonaws.com"
    neptune_write_endpoint                    = "dev-internal-enclave-neptune-cluster-instance-1.cylvzxsvqji5.us-west-2.neptune.amazonaws.com"
    neptune_port                              = "8182"
    neptune_iam_role_arn                      = "arn:aws:iam::687979975259:role/dev-usw2-internal-enclave-neptune-iam-role"
    neptune_iam_role_name                     = "dev-usw2-internal-enclave-neptune-iam-role"
    neptune_cluster_identifier                = "dev-internal-enclave-neptune-cluster"
    budget_role_arn                           = "arn:aws:iam::687979975259:role/dev-usw2-internal-enclave-budget-iam-role"
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}

dependency "data-domain" {
  config_path = "../data-domain-ingestion"
  mock_outputs = {
    event_pipe_id                   = "dev-usw2-internal-enclave-ingest-feedback-event-pipe"
    event_pipe_role_arn             = "arn:aws:iam::687979975259:role/dev-usw2-internal-enclave-ingest-feedback-event-pipe-role"
    feedback_sqs_queue_id           = "https://sqs.us-west-2.amazonaws.com/687979975259/dev-usw2-internal-enclave-ingest-feedback-queue"
    
  }
  mock_outputs_merge_strategy_with_state = "shallow"
}
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  enclave_key                     = local.enclave_name
  enclave_region                  = local.aws_region
  environment                     = local.environment
  
  # Bucket variables
  endor_prestaging_bucket         = dependency.infra.outputs.prestage_s3_bucket_id
  endor_staging_bucket            = dependency.infra.outputs.stage_s3_bucket_id
  endor_ingest_bucket             = dependency.infra.outputs.ingest_s3_bucket_id
  endor_study_scientific_bucket   = dependency.infra.outputs.study_sci_ingress_data_s3_bucket_id
  endor_study_supportive_bucket   = dependency.infra.outputs.study_support_data_s3_bucket_name
  endor_catalog_bucket            = dependency.infra.outputs.org_catalog_bucket_s3_bucket_id
  
  # Queue and endpoints
  data_ingestion_queue            = dependency.infra.outputs.sqs_queue_id
  open_search_endpoint            = dependency.infra.outputs.open_search_endpoint
  
  # Neptune
  neptune_write_endpoint          = dependency.infra.outputs.neptune_write_endpoint
  neptune_port                    = "8182"
  neptune_iam_role_arn            = dependency.infra.outputs.neptune_iam_role_arn
  neptune_assume_role_arn         = dependency.infra.outputs.neptune_iam_role_arn
  neptune_assume_role_name        = dependency.infra.outputs.neptune_iam_role_name
  neptune_cluster_identifier      = dependency.infra.outputs.neptune_cluster_identifier
  
  # ELN and endpoints
  platform_navify_endpoint        = local.global_vars.locals.platform_navify_endpoint
  endor_rest_api_hostname         = local.global_vars.locals.endor_rest_api_hostname

  # Other settings
  sentieon_service_name           = local.global_vars.locals.sentieon_service_name
  
  # OIDC and Platform
  oidcScope                       = local.global_vars.locals.oidcScope
  platform_region                 = local.global_vars.locals.platform_region
  platform_secret_arn             = local.global_vars.locals.platform_secret_arn
  platform_account_id             = local.global_vars.locals.platform_account_id
  platform_domain_api_name        = local.global_vars.locals.platform_domain_api_name
  
  # NFT related
  nft_bucket_id                   = local.global_vars.locals.nft_bucket_id
  nft_ec2_enclave_role_arn        = local.global_vars.locals.nft_ec2_enclave_role_arn
  nft_domain_name                 = local.global_vars.locals.nft_domain_name
  nft_batch_enclave_role_arn      = local.global_vars.locals.nft_batch_enclave_role_arn
  
  # Endor specific
  use_endor_data_domain           = local.global_vars.locals.use_endor_data_domain
  endor_catalog_table_sqs_listener= dependency.data-domain.outputs.feedback_sqs_queue_id
  endor_event_bridge_pipe_name    = dependency.data-domain.outputs.event_pipe_id
  endor_account_id                = local.endor_account_id
  event_bridge_pipe_role_arn      = dependency.data-domain.outputs.event_pipe_role_arn
  cross_account_arn               = local.global_vars.locals.cross_account_arn
  
  # File delete reminders
  day_of_file_delete_first_reminder_email = local.global_vars.locals.day_of_file_delete_first_reminder_email
  day_of_file_delete_second_reminder_email = local.global_vars.locals.day_of_file_delete_second_reminder_email

  #budget role
  endor_budget_role_arn           = dependency.infra.outputs.budget_role_arn
}