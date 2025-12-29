# module "create_param" {
#   count       = var.use_endor_data_domain ? 1 : 0
#   source      = "../terraform-modules/common-modules/terraform-aws-paramstore"
#   param_name  = local.ssm_param_name
#   param_value = "False"
#   param_type  = "String"
# }
