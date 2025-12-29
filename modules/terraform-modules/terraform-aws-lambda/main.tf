resource "aws_lambda_function" "lambda_function" {
  function_name    = var.function_name
  role             = var.role_arn
  runtime          = var.runtime
  handler          = var.lambda_handler
  memory_size      = var.memory_size
  timeout          = var.timeout
  description      = var.description
  layers           = var.create_neptune_opensearch_stream_poller_funtion ? [aws_lambda_layer_version.neptune_opensearch_poller_layer[0].arn] : []
  tags             = var.tags

  filename         = "${path.module}/lambda_function.zip"
  source_code_hash = data.archive_file.python_lambda_package.output_base64sha256

  lifecycle {
    ignore_changes = [ source_code_hash ]
  }

  vpc_config {
    subnet_ids         = var.IAMAuthEnabledOnSourceStream ? var.subnet_ids : []
    security_group_ids = var.IAMAuthEnabledOnSourceStream ? var.vpc_security_group_ids : []
  }

  environment {
    variables = {
      VPC_URL                 = var.vpc_url
      SQS_URL                 = var.sqs_queue_id
      GLUE_JOB_NAME           = var.glue_job_name
      MAX_FILE_COUNT          = var.max_file_count
      MAX_FILE_SIZE_IN_GB     = var.max_file_size_in_gb
      API_DOMAIN              = var.api_domain
      REGION                  = var.region
      REGION_SHORT_NAME       = var.region_short_name
      ENVIRONMENT             = var.environment
      ENCLAVE_ID              = var.enclave_id
      DESTINATION_NAME_SUFFIX = var.destination_name_suffix

      ApplicationName         = var.neptune_opensearch_stream_application_name
      LeaseTable              = var.neptune_opensearch_stream_lease_dynamo_table
      StateMachineName        = var.neptune_opensearch_stream_state_machine_name

      AdditionalParams             = jsonencode(merge(var.stream_poller_additional_params, { "ElasticSearchEndpoint" = var.opensearch_endpoint }))
      Application                  = var.neptune_opensearch_stream_application_name
      IAMAuthEnabledOnSourceStream = var.IAMAuthEnabledOnSourceStream
      #LeaseTable                   = var.neptune_opensearch_stream_lease_dynamo_table
      LoggingLevel                 = var.LoggingLevel
      MaxPollingInterval           = var.MaxPollingInterval
      MaxPollingWaitTime           = var.MaxPollingWaitTime
      NeptuneStreamEndpoint        = var.NeptuneStreamEndpoint
      StreamRecordsBatchSize       = var.StreamRecordsBatchSize
      StreamRecordsHandler         = var.StreamRecordsHandler
      OrgCatalogIndex              = var.OrgCatalogIndex
    }
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  action         = var.action
  function_name  = aws_lambda_function.lambda_function.arn
  principal      = var.principal
  source_arn     = var.source_arn
}

resource "aws_lambda_layer_version" "neptune_opensearch_poller_layer" {
  count               = var.create_neptune_opensearch_stream_poller_funtion ? 1 : 0
  layer_name          = "neptune_opensearch_poller_layer"
  filename            = "${path.module}/stream_poller_layer.zip"
  compatible_runtimes = ["python3.9", "python3.8", "python3.7", "python3.6"]
}