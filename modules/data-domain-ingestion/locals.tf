locals{
  region_name         = split("-", var.enclave_region)
  region_short_name   = format("%s%s%s", local.region_name[0], substr(local.region_name[1], 0, 1), substr(local.region_name[2], 0, 1))
  key                 = lower("${var.enclave_key}")
  key_with_underscore = replace(local.key, "-", "_")

  tags = merge(
    {
      "Enclave" = "${var.enclave_key}"
    },
  )
endor_ingest_event_rule = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-endor-ing-rule"))
endor_ingest_event_arn =  lower(format("%s%s%s%s", "arn:aws:events:", "${var.enclave_region}:", "${var.endor_account_id}:", "rule/${local.endor_ingest_event_rule}"))

endor_ingest_sqs_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-endor-ingest-sqs"))
endor_ingest_sqs_arn = lower(format("%s%s%s%s", "arn:aws:sqs:", "${var.enclave_region}:", "${var.endor_account_id}:", local.endor_ingest_sqs_name))

#endor_ingest_lambda = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-endor-ingest-lambda"))
endor_ingest_lambda  = lower("${local.key}-endor-ingest-lambda")
endor_ingest_role_name   = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-endor-ingest-lambda-role"))
endor_ingest_policy_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-endor-ingest-lambda-policy"))
endor_ingest_lambda_arn = lower(format("%s%s%s%s%s%s", "arn:aws:lambda:", var.enclave_region, ":", var.endor_account_id, ":function:", local.endor_ingest_lambda))

#transfer_lambda_invoke rule
transfer_lambda_invokerule_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-invoke-transferlambda-rule"))

log_account_arn        = format("%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":*")
log_account_lambda_arn = lower(format("%s%s%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":log-group:/aws/lambda/", local.endor_ingest_lambda, ":*"))

endor_ingest_lambda_dirname = "endor_ingest_lambda_code"

sqs_root_access = lower(format("%s%s", "arn:aws:iam::", "${var.endor_account_id}:root"))

batch_job_ecr_repo = lower("${var.enclave_key}-serverless-repository")
batch_job_ecr_repo_uri = "${var.devops_account_id}.dkr.ecr.${var.devops_region}.amazonaws.com/${local.batch_job_ecr_repo}"
batch_job_ecr_repo_arn = "arn:aws:ecr:${var.devops_region}:${var.devops_account_id}:${local.batch_job_ecr_repo}"

batch_job_def_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-batch-job-definition"))
batch_job_queue_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-batch-job-queue"))

compute_env_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-compute-env"))

#batch_service_role_name   = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-batch-service-role"))

batch_task_exec_role = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-ecs-task-role"))
batch_task_exec_policy = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-ecs-task-policy"))

batch_compute_env_sg = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-batch-compute-sg"))


# ssm_param_name = lower(format("%s", "/${local.key}/batch/is-jobrunnig")) 
# ssm_param_arn= lower(format("%s%s%s%s", "arn:aws:ssm:", "${var.enclave_region}:", "${var.endor_account_id}:parameter", local.ssm_param_name))

# #event bridge pipe

# event_pipe_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-event-pipe"))
# event_pipe_policy_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-event-pipe-policy"))
# event_pipe_role_name   = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-event-pipe-role"))

ingest_event_pipe_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-ingest-feedback-event-pipe"))
ingest_event_pipe_policy_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-ingest-feedback-event-pipe-policy"))
ingest_event_pipe_role_name   = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-ingest-feedback-event-pipe-role"))

ingest_event_pipe_sqs_arn = lower(format("%s%s%s%s", "arn:aws:pipes:", "${var.enclave_region}:", "${var.endor_account_id}:pipe/", local.ingest_event_pipe_name))


ingest_feedbck_sqs_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-ingest-feedback-queue"))
ingest_feedbck_sqs_arn = lower(format("%s%s%s%s", "arn:aws:sqs:", "${var.enclave_region}:", "${var.endor_account_id}:", local.ingest_feedbck_sqs_name))
enclave_trust_iam_roles   = ["arn:aws:iam::${var.enclave_account_id}:role/${var.enclave_devops_role}", "arn:aws:iam::${var.enclave_account_id}:role/${var.enclave_engg_role}"]

endor_dynamo_db_stream_arn =  data.aws_dynamodb_table.endor_dynamodb_stream.stream_arn


}