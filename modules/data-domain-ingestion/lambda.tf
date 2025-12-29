module "endor_ingest_lambda" {
  count         = var.use_endor_data_domain ? 1 : 0
  source        = "../terraform-modules/common-modules/terraform-aws-lambda"
  function_name = local.endor_ingest_lambda
  role_arn      = concat(module.lambda_roles_policies.*.role_arn, [""])[0]
  description   = "Lambda function to invoke batch job"
  num_concurrent_executions = 1 # Reserved concurrency set to 1 to restrict lambda from running concurrently
  lambda_dir    = local.endor_ingest_lambda_dirname
  env_vars      = merge({
    API_BASE_URL  = var.endor_api_base_url
    JOB_DEFINITION    = local.batch_job_def_name
    JOB_QUEUE    = local.batch_job_queue_name
    ENCLAVE_SQS_URL = var.ingest_status_sqs_queue_id
    REGION = var.enclave_region
    DEST_BUCKET = var.data_domain_ingest_bucket
    #PARAM_NAME = local.ssm_param_name
  })
  timeout = 900 #15 mins timeout
  memory_size = 2048 #2GB
  action         = "lambda:InvokeFunction"
  principal      = "sqs.amazonaws.com"
  #source_arn     = local.endor_ingest_sqs_arn
  create_sqs_trigger = true
  sqs_queue_arn = local.endor_ingest_sqs_arn
  tags           = local.tags
}