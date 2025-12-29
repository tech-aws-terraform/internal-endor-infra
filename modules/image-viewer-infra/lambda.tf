module "thumbnail_lambda" {
  count         = var.create_image_infra ? 1 : 0
  source        = "../terraform-modules/common-modules/terraform-aws-lambda"
  function_name = local.img_lambda_func_name
  role_arn      = concat(module.lambda_roles_policies.*.role_arn, [""])[0]
  description   = "Lambda function to generate thumbnail images"
  lambda_dir    = local.thumbnail_lambda_dirname
  env_vars      = merge({
    THUMBNAIL_WIDTH  = var.thumb_img_width
    THUMBNAIL_HEIGHT = var.thumb_img_height
    MAX_FILE_SIZE_IN_GB    = var.max_size_toinvoke_glue
    HARD_LIMIT_SIZE_IN_GB    = 58
    GLUE_JOB_NAME    = local.img_glue_job_name
  })
  action         = "lambda:InvokeFunction"
  principal      = "events.amazonaws.com"
  source_arn     = format("%s%s%s%s%s%s", "arn:aws:events:", var.enclave_region, ":", var.endor_account_id, ":rule/", local.img_lambda_event_rule)
  additional_event_trigger = true
  additional_source_arn = [
    format("%s%s%s%s%s%s", "arn:aws:events:", var.enclave_region, ":", var.endor_account_id, ":rule/", local.datasync_thumb_img_rule1),
    format("%s%s%s%s%s%s", "arn:aws:events:", var.enclave_region, ":", var.endor_account_id, ":rule/", local.datasync_thumb_img_rule2)
  ]
  create_layer   = true
  layer_name     = local.layer_name
  layer_filename = local.layer_zip_filename
  tags           = local.tags
}
