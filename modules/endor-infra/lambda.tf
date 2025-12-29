module "auth_lambda" {
  source                     = "../terraform-modules/terraform-aws-lambda"
  function_name              = lower("${local.key}-auth-lambda")
  role_arn                   = concat(module.roles_policies.*.auth_lambda_role_name_arn, [""])[0]
  description                = "Endor ${local.key} Authorization Lambda function"
  region                     = var.enclave_region
  api_domain                 = lower(format("%s%s", "api.", var.enclave_domain_name))
  action                     = "lambda:InvokeFunction"
  principal                  = "transfer.amazonaws.com"
  source_arn                 = lower(format("%s%s%s%s%s", "arn:aws:transfer:", var.enclave_region, ":", var.endor_account_id, ":server*//*"))

  tags = local.tags
}

module "transfer_lambda" {
  source                     = "../terraform-modules/terraform-aws-lambda"
  function_name              = lower("${local.key}-transfer-lambda")
  role_arn                   = concat(module.roles_policies.*.transfer_lambda_role_name_arn, [""])[0]
  description                = "Endor ${local.key} Transfer Lambda function"
  sqs_queue_id               = module.sqs_queue.sqs_queue_id
  max_file_size_in_gb        = 10
  #glue_job_name              = module.transfer_glue.glue_etl_job_id
  region                     = var.enclave_region
  action                     = "lambda:InvokeFunction"
  principal                  = local.transfer_lambda_principal
  source_arn                 = local.transfer_lambda_source_arn
  tags = local.tags
}

module "approval_lambda" {
  source                     = "../terraform-modules/terraform-aws-lambda"
  function_name              = lower("${local.key}-approval-lambda")
  role_arn                   = concat(module.roles_policies.*.approval_lambda_role_name_arn, [""])[0]
  description                = "Endor ${local.key} Approval Lambda function"
  sqs_queue_id               = module.sqs_queue.sqs_queue_id
  max_file_size_in_gb        = 10
  #glue_job_name              = module.approval_glue.glue_etl_job_id
  region                     = var.enclave_region
  api_domain                 = lower(format("%s%s", "api.", var.enclave_domain_name))
  action                     = "lambda:InvokeFunction"
  principal                  = "s3.amazonaws.com"
  source_arn                 = lower(format("%s", "arn:aws:s3:::*"))
  tags = local.tags
}

module "ingest_lambda" {
  count                     = var.use_endor_data_domain ? 0 : 1
  source                     = "../terraform-modules/terraform-aws-lambda"
  function_name              = lower("${local.key}-ingest-lambda")
  role_arn                   = concat(module.roles_policies.*.ingest_lambda_role_name_arn, [""])[0]
  description                = "Endor ${local.key} Ingest Lambda function"
  sqs_queue_id               = module.sqs_queue.sqs_queue_id
  #glue_job_name              = module.ingest_glue.glue_etl_job_id
  region                     = var.enclave_region
  api_domain                 = lower(format("%s%s", "api.", var.enclave_domain_name))
  action                     = "lambda:InvokeFunction"
  principal                  = "sns.amazonaws.com"
  source_arn                 = aws_sns_topic.topic[count.index].arn
  tags = local.tags
}

module "org_catalog_fm_lambda" {
  source                     = "../terraform-modules/terraform-aws-lambda"
  count                      = var.create_org_catalog ? 1 : 0
  function_name              = lower("${local.key}-org-catalog-fm-lambda")
  role_arn                   = concat(module.roles_policies.*.org_catalog_fm_lambda_role_name_arn, [""])[0]
  description                = "Endor ${local.key} Org Catalog FM Lambda function"
  vpc_url                    = var.vpc_url
  sqs_queue_id               = module.sqs_queue.sqs_queue_id
  glue_job_name              = module.org_catalog_fm_glue[0].glue_etl_job_id
  region                     = var.enclave_region
  api_domain                 = lower(format("%s%s", "api.", var.enclave_domain_name))
  action                     = "lambda:InvokeFunction"
  principal                  = "s3.amazonaws.com"
  source_arn                 = lower(format("%s", "arn:aws:s3:::*"))

  tags = local.tags
}

module "org_catalog_data_access_fm_lambda" {
  source                     = "../terraform-modules/terraform-aws-lambda"
  count                      = var.create_org_catalog ? 1 : 0
  function_name              = lower("${local.key}-org-catalog-data-access-fm-lambda")
  role_arn                   = concat(module.roles_policies.*.org_catalog_data_access_fm_lambda_role_name_arn, [""])[0]
  description                = "Endor ${local.key} Org Catalog Data Access FM Lambda function"
  vpc_url                    = var.vpc_url
  sqs_queue_id               = module.sqs_queue.sqs_queue_id
  glue_job_name              = module.org_catalog_data_access_fm_glue[0].glue_etl_job_id
  region                     = var.enclave_region
  api_domain                 = lower(format("%s%s", "api.", var.enclave_domain_name))
  action                     = "lambda:InvokeFunction"
  principal                  = "s3.amazonaws.com"
  source_arn                 = lower(format("%s", "arn:aws:s3:::*"))

  tags = local.tags
}

module "org_catalog_download_lambda" {
  source                     = "../terraform-modules/terraform-aws-lambda"
  count                      = var.create_org_catalog ? 1 : 0
  function_name              = lower("${local.key}-org-catalog-download-lambda")
  role_arn                   = concat(module.roles_policies.*.org_catalog_data_access_fm_lambda_role_name_arn, [""])[0]
  description                = "Endor ${local.key} Org Catalog Data Access FM Lambda function"
  vpc_url                    = var.vpc_url
  sqs_queue_id               = module.sqs_queue.sqs_queue_id
  glue_job_name              = module.org_catalog_download_glue[0].glue_etl_job_id
  region                     = var.enclave_region
  api_domain                 = lower(format("%s%s", "api.", var.enclave_domain_name))
  action                     = "lambda:InvokeFunction"
  principal                  = "s3.amazonaws.com"
  source_arn                 = lower(format("%s", "arn:aws:s3:::*"))

  tags = local.tags
}

module "neptune_opensearch_poller_duplicate_check_lambda" {
  source                                              = "../terraform-modules/terraform-aws-lambda"
  count                                               = var.create_org_catalog ? 1 : 0
  function_name                                       = can(regex("-", var.enclave_key)) ? lower("${local.enclave_short_key}-neptune-duplicate-lambda-execution-check-funtion") : lower("${var.enclave_key}-neptune-duplicate-lambda-execution-check-funtion")
  role_arn                                            = concat(module.roles_policies.*.neptune_duplicate_execution_check_lambda_role_name_arn, [""])[0]
  runtime                                             = var.runtime
  lambda_handler                                      = var.lambda_handler
  timeout                                             = 10
  memory_size                                         = 128
  description                                         = "Neptune Opensearch Stream Duplicate Execution check Lambda Function"
  neptune_opensearch_stream_application_name          = local.neptune_opensearch_stream_application_name
  neptune_opensearch_stream_lease_dynamo_table        = concat(module.neptune_opensearch_poller_dynamodb_table.*.lease_dynamodb_table_name, [""])[0]
  neptune_opensearch_stream_state_machine_name        = local.neptune_opensearch_stream_step_function_name

  action                     = "lambda:InvokeFunction"
  principal                  = "s3.amazonaws.com"

  tags                                                = local.tags
}

module "neptune_restart_state_machine_lambda" {
  source                                              = "../terraform-modules/terraform-aws-lambda"
  count                                               = var.create_org_catalog ? 1 : 0
  function_name                                       = can(regex("-", var.enclave_key)) ? lower("${local.enclave_short_key}-neptune-restart-state-machine-lambda-function") : lower("${var.enclave_key}-neptune-restart-state-machine-lambda-function")
  role_arn                                            = concat(module.roles_policies.*.neptune_restart_statemachine_lambda_role_name_arn, [""])[0]
  runtime                                             = var.runtime
  lambda_handler                                      = var.lambda_handler
  timeout                                             = 10
  memory_size                                         = 128
  description                                         = "Restart Neptune stream poller state machine Lambda Function"
  neptune_opensearch_stream_state_machine_name        = local.neptune_opensearch_stream_step_function_name

  action                     = "lambda:InvokeFunction"
  principal                  = "s3.amazonaws.com"

  tags                                                = local.tags
}

module "neptune_opensearch_stream_poller_lambda" {
  source                                              = "../terraform-modules/terraform-aws-lambda"
  count                                               = var.create_org_catalog ? 1 : 0
  function_name                                       = can(regex("-", var.enclave_key)) ? lower("${local.enclave_short_key}-neptune-opensearch-stream-poller-funtion") : lower("${var.enclave_key}-neptune-opensearch-stream-poller-funtion")
  create_neptune_opensearch_stream_poller_funtion     = true
  role_arn                                            = concat(module.neptune_opensearch_poller_iam_roles_policies.*.neptune_opensearch_stream_poller_lambda_role_name_arn, [""])[0]
  runtime                                             = var.runtime
  lambda_handler                                      = var.lambda_handler
  timeout                                             = var.timeout
  description                                         = "Neptune Opensearch Stream Poller Lambda Function"
  stream_poller_additional_params                     = var.stream_poller_additional_params
  opensearch_endpoint                                 = concat(module.opensearch_serverless.*.oss_collection_endpoint, [""])[0]
  neptune_opensearch_stream_application_name          = local.neptune_opensearch_stream_application_name
  IAMAuthEnabledOnSourceStream                        = true
  neptune_opensearch_stream_lease_dynamo_table        = concat(module.neptune_opensearch_poller_dynamodb_table.*.lease_dynamodb_table_name, [""])[0]
  LoggingLevel                                        = "INFO"
  NeptuneStreamEndpoint                               = "https://${concat(module.neptune_clusters.*.neptune_reader_endpoint, [""])[0]}:${concat(module.neptune_clusters.*.neptune_port, [""])[0]}/gremlin/stream"
  StreamRecordsHandler                                = "neptune_to_es.neptune_gremlin_es_handler.ElasticSearchGremlinHandler"
  OrgCatalogIndex                                     = "amazon_neptune"
  #org_catalog_index                                   = lower("${var.enclave_key}-org-catalog-index")
  subnet_ids                                          = module.org_catalog_vpc[0].neptune_subnets
  vpc_security_group_ids                              = [module.neptune_clusters[0].neptune_cluster_sg_id]

  action                     = "lambda:InvokeFunction"
  principal                  = "s3.amazonaws.com"

  tags                                                = local.tags
}

# Enclave Specific Resources
module "enclave_specific_ingest_lambda" {
  count                      = var.enclave_specific_resource  ? 1 : 0
  source                     = "../terraform-modules/terraform-aws-lambda"
  function_name              = lower("${local.key}-specific-ingest-lambda")
  role_arn                   = concat(module.roles_policies.*.enclave_specific_ingest_lambda_role_name_arn, [""])[0]
  description                = "Endor ${local.key} Enclave Specific Ingest Lambda function"
  sqs_queue_id               = module.sqs_queue.sqs_queue_id
  glue_job_name              = module.enclave_specific_ingest_glue[count.index].glue_etl_job_id
  region                     = var.enclave_region
  api_domain                 = lower(format("%s%s", "api.", var.enclave_domain_name))
  action                     = "lambda:InvokeFunction"
  principal                  = "sns.amazonaws.com"
  source_arn                 = aws_sns_topic.topic[count.index].arn
  region_short_name          = local.region_short_name
  environment                = var.environment
  enclave_id                 = local.key
  destination_name_suffix    = lower("sci-ingress-data-s3")

  tags = local.tags
}