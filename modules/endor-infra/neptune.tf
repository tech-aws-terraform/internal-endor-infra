module "neptune_clusters" {
  source                   = "../terraform-modules/terraform-aws-neptune"
  count                    = var.create_org_catalog ? 1 : 0
  vpc_id                   = module.org_catalog_vpc[0].vpc_id
  subnet_ids               = concat(module.org_catalog_vpc.*.neptune_subnets, [""])[0]
  neptune_subnets          = var.neptune_subnets
  cluster_identifier       = lower("${var.environment}-${var.enclave_key}-neptune-cluster")
  neptune_role_name        = lower("${var.environment}-${local.region_short_name}-${var.enclave_key}-neptune-iam-role")
  neptune_role_description = lower("${var.enclave_key} neptune role")
  instance_count           = var.instance_count
  max_capacity             = var.max_nep_capacity
  min_capacity             = var.min_nep_capacity
  enclave_key              = var.enclave_key
  #create_neptune_notebook  = var.create_neptune_notebook
  neptune_notebook_name    = lower("${var.environment}-${var.enclave_key}-neptune-notebook")
  org_neptune_s3_bucket_arn = concat(module.org_catalog_s3.*.bucket_arn, [""])[0]
  org_neptune_s3_bucket_id  = concat(module.org_catalog_s3.*.bucket_id, [""])[0]
  account_id                = var.endor_account_id
  cidr                      = var.enclave_base_vpc_cidr
  enclave_trust_iam_roles   = local.enclave_trust_iam_roles
  neptune_policy_name       = lower("${var.environment}-${local.region_short_name}-${var.enclave_key}-neptune-policy")
  deletion_protection       = var.deletion_protection
  vpc_security_group_ids    = [module.org_catalog_vpc[0].org_vpc_https_sg]

  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  neptune_sagemaker_role_name         = lower("${var.environment}-${local.region_short_name}-${var.enclave_key}-neptune-notebook-role")
  neptune_sagemaker_policy_name       = lower("${var.environment}-${local.region_short_name}-${var.enclave_key}-neptune-notebook8-policy")
  region                              = var.enclave_region

  tags                      = local.tags
}

module "opensearch_serverless" {
  source                        = "../terraform-modules/terraform-aws-opensearch"
  count                         = var.create_org_catalog ? 1 : 0
  enclave_key                   = var.enclave_key
  oss_collection_name           = can(regex("-", var.enclave_key)) ? lower("${var.environment}-${local.enclave_short_key}-oss-collection") : lower("${var.environment}-${var.enclave_key}-oss-collection")
  oss_data_access_policy_name   = can(regex("-", var.enclave_key)) ? lower("${local.enclave_short_key}-oss-access-policy") : lower("${var.enclave_key}-oss-access-policy")
  oss_security_encryption_policy_name         = can(regex("-", var.enclave_key)) ? lower("${local.enclave_short_key}-oss-encyption") : lower("${var.enclave_key}-oss-encyption")
  oss_security_network_policy_vpc_access_name = can(regex("-", var.enclave_key)) ? lower("${local.enclave_short_key}-oss-network") : lower("${var.enclave_key}-oss-network")
  oss_vpc_endpoint_name         = lower("${var.environment}-${var.enclave_key}-vpce")
  private_subnet_ids            = module.org_catalog_vpc[0].neptune_subnets
  vpc_id                        = module.org_catalog_vpc[0].vpc_id
  vpc_security_group            = module.neptune_clusters[0].neptune_cluster_sg_id
  #neptune_opensearch_stream_poller_funtion_arn = module.neptune_opensearch_stream_poller_lambda[count.index].neptune_opensearch_stream_poller_funtion_arn
  principal                     = [concat(module.neptune_opensearch_poller_iam_roles_policies.*.neptune_opensearch_stream_poller_lambda_role_name_arn, [""])[0], module.neptune_clusters[0].neptune_iam_auth_role_arn, lower("arn:aws:iam::${var.endor_account_id}:root")]

  tags                          = local.tags
}