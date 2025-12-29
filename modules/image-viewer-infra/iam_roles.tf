##### Thumbnail Lambda Role & Policy #####
module "lambda_roles_policies" {
  count              = var.create_image_infra ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-iam-role"
  role_name          = local.img_lambda_role_name
  policy_name        = local.img_lambda_policy_name
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  policy             = data.aws_iam_policy_document.thumbnail_lambda_policy.json
  tags               = local.tags
}

module "eventrule_roles_policies" {
  count              = local.create_endor_thumbimg_infra ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-iam-role"
  role_name          = local.img_eventrule_role_name
  policy_name        = local.img_eventrule_policy_name
  assume_role_policy = data.aws_iam_policy_document.thumbnail_eventrule_role.json
  policy             = data.aws_iam_policy_document.thumbnail_eventrule_policy.json
  tags               = local.tags
}