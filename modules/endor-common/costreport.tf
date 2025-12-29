resource "aws_cur_report_definition" "kamino_cur_report_definition" {
  count    = var.enable_cur_report ? 1 : 0
  provider = aws.global_region

  report_name               = "${local.resource_prefix}-${local.enclave_short_key}-endor-cur-report"
  time_unit                 = "HOURLY"
  format                    = "Parquet"
  compression               = "Parquet"
  additional_schema_elements = ["RESOURCES", "SPLIT_COST_ALLOCATION_DATA"]
  s3_bucket                 = concat(module.billing_bucket.*.bucket_id, [""])[0]
  s3_prefix                 = "billing-reports/${data.aws_caller_identity.current.account_id}/"
  s3_region                 = "eu-central-1"
  refresh_closed_reports    = true
  report_versioning        = "OVERWRITE_REPORT"
}