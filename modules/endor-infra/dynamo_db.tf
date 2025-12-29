module "dynamodb_table" {
  source                          = "../terraform-modules/terraform-aws-dynamodb"
  create_metadata_table           = true
  environment                     = var.environment
  dynamodb_tbl_name               = lower("${local.key}-metadata")
  point_in_time_recovery_enabled  = var.point_in_time_recovery_enabled

  tags = local.tags
}

module "neptune_opensearch_poller_dynamodb_table" {
  source                                      = "../terraform-modules/terraform-aws-dynamodb"
  count                                       = var.create_org_catalog ? 1 : 0
  create_neptune_poller_table                 = var.create_neptune_poller_table
  environment                                 = var.environment
  dynamodb_tbl_name                           = lower("${local.key}-neptune-os-poller")
  neptune_opensearch_stream_application_name  = local.neptune_opensearch_stream_application_name

  tags                                        = local.tags
}