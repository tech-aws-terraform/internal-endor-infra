module "prestage_bucket" {
  source                          = "../terraform-modules/terraform-aws-s3"
  create_bucket                   = true
  create_bucket_lc                = false
  create_prestage_bucket_lc       = true
  create_bucket_object            = true
  create_bucket_notification      = local.create_bucket_notification
  enable_event_bridge             = var.use_endor_data_domain
  create_cors_policy              = true
  create_prestage_bucket_policy   = true
  s3_bucket_name                  = lower("${var.environment}-${local.region_short_name}-${local.key}-prestaging-s3")
  enclave_trust_iam_roles         = local.enclave_trust_iam_roles
  lambda_function_arn             = module.transfer_lambda.lambda_arn
  s3_cors_origins                 = local.s3_cors_origins
  #bucket_lc_rule                  = var.prestaging_bucket_lc_rule
  prestaging_bucket_lc_rule       = var.prestaging_bucket_lc_rule
  event_notification_prefix       = "metadata/"
  event_notification_suffix       = ".json"
  enclave_account_id              = var.enclave_account_id
  enclave_root_trust_iam_roles    = local.enclave_root_trust_iam_roles
  depends_on                      = [module.transfer_lambda]
  tags                            = merge(local.tags, local.prestaging_bucket_tag)
}

module "stage_bucket" {
  source                          = "../terraform-modules/terraform-aws-s3"
  create_bucket                   = true
  create_bucket_lc                = true
  create_bucket_object            = true
  create_bucket_notification      = true
  create_cors_policy              = true
  create_stage_bucket_policy      = true
  s3_bucket_name                  = lower("${var.environment}-${local.region_short_name}-${local.key}-staging-s3")
  enclave_trust_iam_roles         = local.enclave_trust_iam_roles
  lambda_function_arn             = module.approval_lambda.lambda_arn
  s3_cors_origins                 = local.s3_cors_origins
  bucket_lc_rule                  = var.bucket_lc_rule
  event_notification_prefix       = "metadata/"
  event_notification_suffix       = ".json"
  enclave_account_id              = var.enclave_account_id
  depends_on                      = [module.approval_lambda]
  tags                            = merge(local.tags, local.prestaging_bucket_tag)
}

module "ingest_bucket" {
  source                            = "../terraform-modules/terraform-aws-s3"
  create_bucket                     = true
  create_bucket_lc                  = true
  create_bucket_object              = true
  create_bucket_versioning          = true
  create_ingest_bucket_policy       = true
  s3_bucket_name                    = lower("${var.environment}-${local.region_short_name}-${local.key}-ingest-s3")
  datasync_crossaccount_role        = var.datasync_crossaccount_role
  enclave_root_trust_iam_roles      = local.enclave_root_trust_iam_roles
  #enclave_trust_iam_roles           = local.enclave_trust_iam_roles
  bucket_lc_rule                    = var.bucket_lc_rule
  enclave_account_id                = var.enclave_account_id
  versioning                        = "Enabled"
  tags                              = merge(local.tags, local.stage_bucket_tag)
  enable_event_bridge               = var.use_endor_data_domain
}

resource "aws_s3_bucket_notification" "sns_notification" {
  #create sns topic only if use_endor_data_domain is false
  count = var.use_endor_data_domain ? 0 : 1
  bucket                = concat(module.ingest_bucket.*.bucket_id, [""])[0]
  topic {
    topic_arn           = aws_sns_topic.topic[count.index].arn
    events              = ["s3:ObjectCreated:*"]
  }
}

module "study_sci_ingress_data_bucket" {
  source                          = "../terraform-modules/terraform-aws-s3"
  create_bucket                   = true
  create_cors_policy              = true
  create_study_sci_bucket_policy  = true
  s3_bucket_name                  = lower("${var.environment}-${local.region_short_name}-${local.key}-study-sci-ingress-data-s3")
  enclave_trust_iam_roles         = local.enclave_trust_iam_roles
  enclave_root_iam_role           = local.enclave_root_iam_role
  s3_cors_origins                 = local.s3_cors_origins
  bucket_lc_rule                  = var.bucket_lc_rule
  enclave_account_id              = var.enclave_account_id
  tags                            = merge(local.tags, local.study_sci_ingress_data_bucket_tag)
}

module "study_supportive_data_bucket" {
  source                          = "../terraform-modules/terraform-aws-s3"
  create_bucket                   = true
  create_bucket_lc                = true
  create_cors_policy              = true
  create_study_sup_bucket_policy  = true
  s3_bucket_name                  = lower("${var.environment}-${local.region_short_name}-${local.key}-study-supportive-data-s3")
  enclave_trust_iam_roles         = local.enclave_trust_iam_roles
  enclave_root_iam_role           = local.enclave_root_iam_role
  s3_cors_origins                 = local.s3_cors_origins
  bucket_lc_rule                  = var.bucket_lc_rule
  enclave_account_id              = var.enclave_account_id
  tags                            = merge(local.tags, local.study_sup_data_bucket_tag)
}

module "org_catalog_s3" {
  source                            = "../terraform-modules/terraform-aws-s3"
  count                             = var.create_org_catalog ? 1 : 0
  s3_bucket_name                    = local.org_catalog_bucket_name
  create_bucket                     = true
  create_bucket_ownership           = true
  create_bucket_object              = true
  create_org_catalog_bucket_policy  = true

  create_org_cat_bucket_notification = true

  enclave_trust_iam_roles         = local.enclave_trust_iam_roles
  bucket_lc_rule                  = var.bucket_lc_rule
  event_notification_prefix       = "metadata/"
  event_notification_suffix       = ".json"

  #enclave_key                  = var.enclave_key
  #region                       = var.enclave_region
  enclave_account_id           = var.enclave_account_id

  org_catalog_fm_lambda_function_arn              = concat(module.org_catalog_fm_lambda.*.lambda_arn, [""])[0]
  org_catalog_data_access_fm_lambda_function_arn  = concat(module.org_catalog_data_access_fm_lambda.*.lambda_arn, [""])[0]
  org_catalog_download_lambda_function_arn        = concat(module.org_catalog_download_lambda.*.lambda_arn, [""])[0]

  tags                                            = local.tags
  depends_on = [module.stage_bucket]
}
