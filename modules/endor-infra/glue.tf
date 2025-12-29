# module "transfer_glue" {
#   source                  = "../terraform-modules/terraform-aws-glue"
#   glue_job_name           = local.transfer_glue_job_name
#   command_name            = var.command_name
#   role_arn                = concat(module.glue_job_roles_policies.*.glue_job_iam_role_arn, [""])[0]
#   script_location         = var.transfer_glue_script_location
#   max_concurrent_runs     = var.max_concurrent_runs
#   sqs_url                 = module.sqs_queue.sqs_queue_id
#   vpc_url                 = var.vpc_url
#   max_capacity            = var.max_capacity
#   python_version          = var.python_version

#   tags = local.tags
# }

# module "approval_glue" {
#   source                  = "../terraform-modules/terraform-aws-glue"
#   glue_job_name           = local.approval_glue_job_name
#   command_name            = var.command_name
#   role_arn                = concat(module.glue_job_roles_policies.*.glue_job_iam_role_arn, [""])[0]
#   script_location         = var.approval_glue_script_location
#   max_concurrent_runs     = var.max_concurrent_runs
#   sqs_url                 = module.sqs_queue.sqs_queue_id
#   vpc_url                 = var.vpc_url
#   max_capacity            = var.max_capacity
#   python_version          = var.python_version

#   tags = local.tags
# }

# module "ingest_glue" {
#   source                  = "../terraform-modules/terraform-aws-glue"
#   glue_job_name           = local.ingest_glue_job_name
#   command_name            = var.command_name
#   role_arn                = concat(module.glue_job_roles_policies.*.glue_job_iam_role_arn, [""])[0]
#   script_location         = var.ingest_glue_script_location
#   max_concurrent_runs     = var.max_concurrent_runs
#   sqs_url                 = module.sqs_queue.sqs_queue_id
#   vpc_url                 = var.vpc_url
#   max_capacity            = var.max_capacity
#   python_version          = var.python_version

#   tags = local.tags
# }

module "org_catalog_fm_glue" {
  source                  = "../terraform-modules/terraform-aws-glue"
  count                   = var.create_org_catalog ? 1 : 0
  glue_job_name           = local.org_cat_fm_glue_job_name
  command_name            = var.command_name
  role_arn                = concat(module.glue_job_roles_policies.*.glue_job_iam_role_arn, [""])[0]
  script_location         = var.org_cat_fm_glue_script_location
  max_concurrent_runs     = var.max_concurrent_runs
  sqs_url                 = module.sqs_queue.sqs_queue_id
  vpc_url                 = var.vpc_url
  max_capacity            = var.max_capacity
  python_version          = var.python_version

  tags = local.tags
}

module "org_catalog_data_access_fm_glue" {
  source                  = "../terraform-modules/terraform-aws-glue"
  count                   = var.create_org_catalog ? 1 : 0
  glue_job_name           = local.org_cat_data_access_fm_glue_job_name
  command_name            = var.command_name
  role_arn                = concat(module.glue_job_roles_policies.*.glue_job_iam_role_arn, [""])[0]
  script_location         = var.org_cat_data_access_fm_glue_script_location
  max_concurrent_runs     = var.max_concurrent_runs
  sqs_url                 = module.sqs_queue.sqs_queue_id
  vpc_url                 = var.vpc_url
  max_capacity            = var.max_capacity
  python_version          = var.python_version

  tags = local.tags
}

module "org_catalog_download_glue" {
  source                  = "../terraform-modules/terraform-aws-glue"
  count                   = var.create_org_catalog ? 1 : 0
  glue_job_name           = local.org_cat_download_glue_job_name
  command_name            = var.command_name
  role_arn                = concat(module.glue_job_roles_policies.*.glue_job_iam_role_arn, [""])[0]
  script_location         = var.org_cat_download_glue_script_location
  max_concurrent_runs     = var.max_concurrent_runs
  sqs_url                 = module.sqs_queue.sqs_queue_id
  vpc_url                 = var.vpc_url
  max_capacity            = var.max_capacity
  python_version          = var.python_version

  tags = local.tags
}

# Enclave Specific Resources
module "enclave_specific_ingest_glue" {
  count                   = var.enclave_specific_resource ? 1 : 0
  source                  = "../terraform-modules/terraform-aws-glue"
  glue_job_name           = local.enclave_specific_ingest_glue_job_name
  command_name            = var.command_name
  role_arn                = concat(module.glue_job_roles_policies.*.glue_job_iam_role_arn, [""])[0]
  script_location         = var.enclave_specific_ingest_glue_script_location
  max_concurrent_runs     = var.max_concurrent_runs
  sqs_url                 = module.sqs_queue.sqs_queue_id
  vpc_url                 = var.vpc_url
  max_capacity            = var.max_capacity
  python_version          = var.python_version

  tags = local.tags
}