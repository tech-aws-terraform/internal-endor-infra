
# module "eventbridge_pipe"{
#   count       = var.use_endor_data_domain ? 1 : 0
#   source      = "../terraform-modules/common-modules/terraform-aws-eventbridge-pipe"
#   pipe_name = local.event_pipe_name
#   assume_role_arn = concat(module.event_pipe_roles_policies.*.role_arn, [""])[0]
#   source_arn = module.sqs_queue.sqs_queue_arn
#   target_arn = concat(module.ingest_step_func.*.state_machine_arn, [""])[0]
#   source_role_policy = data.aws_iam_policy_document.endor_ingest_sqs_policy.json
#   target_role_policy = data.aws_iam_policy_document.step_func_policy.json
# }

module "eventbridge_pipe"{
  count       = var.use_endor_data_domain ? 1 : 0
  source      = "../terraform-modules/common-modules/terraform-aws-eventbridge-pipe"
  pipe_name = local.ingest_event_pipe_name
  assume_role_arn = concat(module.ing_event_pipe_roles_policies.*.role_arn, [""])[0]
  source_arn = local.endor_dynamo_db_stream_arn
  target_arn = concat(module.ingest_feedback_sqs_queue.*.sqs_queue_arn, [""])[0]
  #source_role_policy = data.aws_iam_policy_document.endor_ingest_sqs_policy.json
  target_role_policy = data.aws_iam_policy_document.ingest_feedback_sqs_policy.json
}