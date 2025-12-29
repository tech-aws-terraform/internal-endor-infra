module "sqs_queue" {
  source                        = "../terraform-modules/common-modules/terraform-aws-sqs"
  sqs_queue_name                = local.endor_ingest_sqs_name
  sqs_visibility_timeout        = 900 #15 mins
  policy                        = data.aws_iam_policy_document.endor_ingest_sqs_policy.json
  tags                          = local.tags
}

module "ingest_feedback_sqs_queue" {
  source                        = "../terraform-modules/common-modules/terraform-aws-sqs"
  sqs_queue_name                = local.ingest_feedbck_sqs_name
  sqs_visibility_timeout        = 900 #15 mins
  policy                        = data.aws_iam_policy_document.ingest_feedback_sqs_policy.json
  tags                          = local.tags
}