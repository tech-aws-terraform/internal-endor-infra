module "waf" {
  source                            = "../terraform-modules/terraform-aws-waf"
  transfer_secured_waf_name         = lower("${local.key}-${local.region_short_name}-waf")
  transfer_secured_metric_name      = lower("${local.key}-${local.region_short_name}-waf-metric")
  scope                             = var.scope
  regex_pattern_str                 = var.regex_pattern_str
  transfer_secure_api_stage_arn     = module.api_gateway.transfer_secure_api_stage_arn

  tags = local.tags
}