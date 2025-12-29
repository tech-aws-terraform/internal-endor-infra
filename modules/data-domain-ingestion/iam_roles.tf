##### Endor Ingest Lambda Role & Policy #####
module "lambda_roles_policies" {
  count              = var.use_endor_data_domain ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-iam-role"
  role_name          = local.endor_ingest_role_name
  policy_name        = local.endor_ingest_policy_name
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  policy             = data.aws_iam_policy_document.endor_ingest_lambda_policy.json
  tags               = local.tags
}

module "ecs_task_role_policies" {
  count              = var.use_endor_data_domain ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-iam-role"
  role_name          = local.batch_task_exec_role
  policy_name        = local.batch_task_exec_policy
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
  policy             = data.aws_iam_policy_document.ecs_task_exec_policy.json
  attach_exist_policies = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
  tags = local.tags
}


module "ing_event_pipe_roles_policies" {
  count              = var.use_endor_data_domain ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-iam-role"
  role_name          = local.ingest_event_pipe_role_name
  policy_name        = local.ingest_event_pipe_policy_name
  assume_role_policy = data.aws_iam_policy_document.feedback_pipe_assume_role.json
  policy             = data.aws_iam_policy_document.feedback_pipe_policy.json
  tags               = local.tags
}



# resource "aws_iam_service_linked_role" "batch_service_role" {
#   count             =  var.create_batch_service_role ? 1 : 0
#   aws_service_name  = "batch.amazonaws.com"
#   description       = "Service linked role for Batch"
#   lifecycle {
#     ignore_changes = all
#   }
# }


# module "event_pipe_roles_policies" {
#   count              = var.use_endor_data_domain ? 1 : 0
#   source             = "../terraform-modules/common-modules/terraform-aws-iam-role"
#   role_name          = local.event_pipe_name
#   policy_name        = local.event_pipe_policy_name
#   assume_role_policy = data.aws_iam_policy_document.event_pipe_assume_role.json
#   policy             = data.aws_iam_policy_document.event_pipe_policy.json
#   tags               = local.tags
# }

# module "step_func_roles_policies" {
#   count              = var.use_endor_data_domain ? 1 : 0
#   source             = "../terraform-modules/common-modules/terraform-aws-iam-role"
#   role_name          = local.ingest_step_func_role_name
#   policy_name        = local.ingest_step_func_policy_name
#   assume_role_policy = data.aws_iam_policy_document.step_func_assume_role.json
#   policy             = data.aws_iam_policy_document.step_func_policy.json
#   tags               = local.tags
# }