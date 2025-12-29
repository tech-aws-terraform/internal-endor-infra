module "api_gateway" {
  source                             = "../terraform-modules/terraform-aws-apigw"
  apigw_rest_api_name                = lower("${local.key}-${local.region_short_name}-transfer-secure-apigw")
  api_gw_stage_name                  = var.api_gw_stage_name
  region                             = var.enclave_region
  auth_lambda_arn                    = module.auth_lambda.lambda_arn
  throttle_burst_lt                  = var.throttle_burst_lt
  throttle_rate_lt                   = var.throttle_rate_lt
  auth_lambda_func                   = lower("${local.key}-auth-lambda")
  api_resource_path                  = var.api_resource_path
  logging_level                      = var.logging_level
  apigw_cw_role_arn                  = module.roles_policies.apigw_cw_role_arn

  tags  = local.tags
  depends_on = [ module.roles_policies ]
}