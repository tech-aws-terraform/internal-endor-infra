module "org_catalog_vpc" {
  source          = "../terraform-modules/terraform-aws-vpc"
  count           = var.create_org_catalog ? 1 : 0
  vpc_name        = lower("${var.environment}-${local.region_short_name}-${var.enclave_key}-org-catalog")
  cidr            = var.cidr
  azs             = var.azs
  public_subnets  = var.public_subnets
  neptune_subnets = var.neptune_subnets
  enclave_key     = var.enclave_key
  region          = var.enclave_region
  tags            = local.tags
}

module "vpc_peering" {
  source                = "../terraform-modules/terraform-aws-vpc-peer"
  count                 = var.create_org_catalog ? 1 : 0
  accepter_cidr         = var.accepter_cidr
  accepter_owner_id     = var.enclave_account_id
  accepter_region       = var.enclave_region
  accepter_vpc_id       = var.accepter_vpc_id
  requester_pvt_rt      = module.org_catalog_vpc[0].private_rtb_id
  requester_vpc_id      = module.org_catalog_vpc[0].vpc_id
  tags                  = local.tags
}
