#################
# Appsync
#################
/*module "appsync" {
  source                               = "../terraform-modules/terraform-aws-appsync"
  appsync_graphql_api_name             = lower("${local.key}-${local.region_short_name}-appsync-api")
  log_cloudwatch_logs_role_arn         = concat(module.roles_policies.*.appsync_cw_iam_role_arn, [""])[0]
  datasource_name                      = lower("${local.key_with_underscore}_${local.region_short_name}_datasource")
  service_role_arn                     = concat(module.roles_policies.*.appsync_dynamodb_iam_role_arn, [""])[0]
  dynamodb_table_name                  = module.dynamodb_table.dynamodb_table_id
  api_key_description                  = "Appsync API key"
  api_key_expires                      = var.api_key_expires

  tags = local.tags
}*/