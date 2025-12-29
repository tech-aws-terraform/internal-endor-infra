locals {
  region_name         = split("-", var.enclave_region)
  region_short_name   = format("%s%s%s", local.region_name[0], substr(local.region_name[1], 0, 1), substr(local.region_name[2], 0, 1))
  key                 = lower("${var.enclave_key}")
  key_with_underscore = replace(local.key, "-", "_")

  tags = merge(
    {
      "Enclave" = "${var.enclave_key}"
    },
  )
  
  img_lambda_event_rule  = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-invoke-imglambda-rule"))
  img_eventrule_role_name   = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-thumbnail-eventrule-role"))
  img_eventrule_policy_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-thumbnail-eventrule-policy"))
   
  datasync_thumb_img_rule1  = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-datasync-img-rule-1"))
  datasync_thumb_img_rule2  = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-datasync-img-rule-2"))

  #img_lambda_func_name   = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-thumbnail-image-lambda"))
  img_lambda_func_name   =  lower("${local.key}-thumbnail-image-lambda")
  img_lambda_role_name   = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-thumbnail-lambda-role"))
  img_lambda_policy_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-thumbnail-lambda-policy"))
  log_account_arn        = format("%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":*")
  log_account_lambda_arn = lower(format("%s%s%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":log-group:/aws/lambda/", local.img_lambda_func_name, ":*"))

  img_glue_job_name    = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-thumbnail-glue-job"))
  img_glue_job_arn     = lower(format("%s%s%s%s%s%s", "arn:aws:glue:", var.enclave_region, ":", var.endor_account_id, ":job/", local.img_glue_job_name))
  img_glue_role_name   = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-thumbnail-glue-role"))
  img_glue_policy_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-thumbnail-glue-policy"))

  layer_name               = "pillow_layer"
  layer_zip_filename       = "pillow_layer_python3.9.zip"
  thumbnail_lambda_dirname = "thumbnail_lambda_code"
  glue_extra_pymodule = "Pillow==9.4.0"

  #ingestion
  ingest_event_rule = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-invoke-transferlambda-rule"))

  #enclave thumbnail sqs
  enclave_thubmnail_queue1_name = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", "${var.enclave_key}", "-thumbnail-queue-1"))
  enclave_thubmnail_queue1_arn = lower(format("%s%s%s%s", "arn:aws:sqs:", "${var.enclave_region}:", "${var.enclave_account_id}:", local.enclave_thubmnail_queue1_name))

  # True to create thumbnail image infra on endor account (event rule only)
  create_endor_thumbimg_infra	   = var.create_image_infra ? false : true 
  
}