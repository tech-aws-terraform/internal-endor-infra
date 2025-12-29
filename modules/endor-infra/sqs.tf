module "sqs_queue" {
  source                        = "../terraform-modules/terraform-aws-sqs"
  sqs_queue_name                = lower("${local.key}-sqs")
  endor_account_id              = var.endor_account_id
  enclave_trust_iam_roles       = local.enclave_trust_iam_roles

  tags = local.tags
}

module "org_catalog_sqs_queue" {
  source                        = "../terraform-modules/terraform-aws-sqs"
  count                         = var.create_org_catalog ? 1 : 0
  sqs_queue_name                = lower("${local.key}-org-catalog-sqs")
  endor_account_id              = var.endor_account_id
  enclave_trust_iam_roles       = local.enclave_trust_iam_roles

  tags = local.tags
}