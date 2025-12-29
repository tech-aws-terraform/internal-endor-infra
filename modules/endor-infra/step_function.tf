module "neptune_opensearch_poller_step_function" {
  source                                                = "../terraform-modules/terraform-aws-step-function"
  count                                                 = var.create_org_catalog ? 1 : 0
  neptune_opensearch_poller_state_machine_name          = lower("${var.enclave_key}-neptune-opensearch-poller-step-funtion")
  neptune_opensearch_poller_state_machine_iam_arn       = concat(module.roles_policies.*.neptune_stream_poller_step_function_name_arn, [""])[0]
  neptune_duplicate_lambda_execution_check_funtion_arn  = concat(module.neptune_opensearch_poller_duplicate_check_lambda.*.lambda_arn, [""])[0]
  neptune_opensearch_stream_poller_funtion_arn          = concat(module.neptune_opensearch_stream_poller_lambda.*.lambda_arn, [""])[0]
  neptune_restart_state_machine_funtion_arn             = concat(module.neptune_restart_state_machine_lambda.*.lambda_arn, [""])[0]
  tags                                                  = local.tags
  depends_on = [ module.roles_policies,  module.neptune_opensearch_poller_duplicate_check_lambda, module.neptune_opensearch_stream_poller_lambda, module.neptune_restart_state_machine_lambda ]
}