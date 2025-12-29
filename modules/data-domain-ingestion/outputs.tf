output "sqs_queue_id" {
  description = "Endor ingest SQS Queue Id"
  value       = concat(module.sqs_queue.*.sqs_queue_id, [""])[0]
}

output "sqs_queue_arn" {
  description = "Endor ingest SQS Queue ARN"
  value       = concat(module.sqs_queue.*.sqs_queue_arn, [""])[0]
}

output "endor_ingest_event_rule_arn" {
  description = "endor_ingest Lambda ARN"
  value       = concat(module.endor_ingest_event_rule.*.event_role_arn, [""])[0]
}

output "endor_ingest_lambda_arn" {
  description = "endor_ingest Lambda ARN"
  value       = concat(module.endor_ingest_lambda.*.lambda_arn, [""])[0]
}

output "endor_ingest_lambda_role_name" {
  description = "endor_ingest Lambda Role Name"
  value       = concat(module.lambda_roles_policies.*.role_name, [""])[0]
}

output "endor_ingest_lambda_role_name_arn" {
  description = "endor_ingest Lambda Role ARN"
  value       = concat(module.lambda_roles_policies.*.role_arn, [""])[0]
}


output "security_group_id" {
  description = "Batch job Compute environmnet security group id"
  value       = concat(module.batch_compute_env_sg.*.security_group_id, [""])[0]
}

output "ecs_task_role_arn" {
  description = "ECS Task Role ARN"
  value       = concat(module.ecs_task_role_policies.*.role_arn, [""])[0]
}

output "ecs_task_role_name" {
  description = "ECS Taks Role Name"
  value       = concat(module.ecs_task_role_policies.*.role_name, [""])[0]
}

output "feedback_sqs_queue_id" {
  description = "Endor ingest feedback SQS Queue Id"
  value       = concat(module.ingest_feedback_sqs_queue.*.sqs_queue_id, [""])[0]
}

output "feedback_sqs_queue_arn" {
  description = "Endor ingest feedback SQS Queue ARN"
  value       = concat(module.ingest_feedback_sqs_queue.*.sqs_queue_arn, [""])[0]
}

output "event_pipe_role_arn" {
  description = "ingest feedback event pipe role arn"
  value = concat(module.ing_event_pipe_roles_policies.*.role_arn, [""])[0]
}

output "event_pipe_arn" {
  description = "ingest feedback event pipe arn"
  value = concat(module.eventbridge_pipe.*.event_pipe_arn, [""])[0]
}

output "event_pipe_id" {
  description = "ingest feedback event pipe id"
  value = concat(module.eventbridge_pipe.*.event_pipe_id, [""])[0]
}

# output "step_func_role_arn" {
#   description = "step function role arn"
#   value       = concat(module.step_func_roles_policies.*.role_arn, [""])[0]
# }


# output "event_pipe_role_arn" {
#   description = "event pipe role arn"
#   value = concat(module.event_pipe_roles_policies.*.role_arn, [""])[0]
  
# }

# output "ingest_state_machine_arn" {
#   description = "Endor Ingest state machine"
#   value = concat(module.ingest_step_func.*.state_machine_arn, [""])[0]
# }
