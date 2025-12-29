
# data "template_file" "ingest_step_func_template" {
#   template = file("${path.module}/templates/sfn-endor-ingest.json")
#   vars = {
#     invoke_lambda_arn   = local.endor_ingest_lambda_arn
#     param_name    = local.ssm_param_name
#     param_val     = "True"
#     #wait_time = 30 #seconds
#   }
# }

# module "ingest_step_func"{
#     count       = var.use_endor_data_domain ? 1 : 0
#     source      = "../terraform-modules/common-modules/terraform-aws-stepfunction"
#     state_machine_name = local.ingest_step_func_name
#     state_machine_role_arn = concat(module.step_func_roles_policies.*.role_arn, [""])[0]
#     state_machine_definition = data.template_file.ingest_step_func_template.rendered
# }