resource "aws_sfn_state_machine" "neptune_stream_poller_state_machine" {
  name     = var.neptune_opensearch_poller_state_machine_name
  role_arn = var.neptune_opensearch_poller_state_machine_iam_arn
  definition = templatefile("${path.module}/templates/neptune_opensearch_poller_state_machine_definition.tftpl", {
    check_for_lambda_duplicate_execution_arn = var.neptune_duplicate_lambda_execution_check_funtion_arn
    stream_poller_lambda_arn                 = var.neptune_opensearch_stream_poller_funtion_arn
    restart_state_machine_execution_arn      = var.neptune_restart_state_machine_funtion_arn
  })

  tags = var.tags
}