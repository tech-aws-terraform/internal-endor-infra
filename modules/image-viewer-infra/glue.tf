module "thumbnail_glue" {
  count               = var.create_image_infra ? 1 : 0
  source              = "../terraform-modules/common-modules/terraform-aws-glue"
  glue_job_name       = local.img_glue_job_name
  role_arn            = var.glue_job_iam_role_arn
  script_location     = var.img_glue_script_location
  max_concurrent_runs = var.max_glue_concurrent_runs
  max_retries         = var.max_retries
  worker_type         = var.worker_type
  no_of_workers       = var.no_of_workers
  timeout             = var.timeout
  env_vars            = merge({
    "--THUMBNAIL_HEIGHT"                 = var.thumb_img_width
    "--THUMBNAIL_WIDTH"                  = var.thumb_img_height
    "--additional-python-modules"        = local.glue_extra_pymodule
    "--enable-auto-scaling"              = true
    "--enable-metrics"                   = true
    "--enable-continuous-cloudwatch-log" = true
    #"--enable-spark-ui"                  = true
    "--enable-job-insights"              = true
    "--enable-auto-scaling"              = true
    #"--spark-event-logs-path"            = var.spark_s3_logs_path
  })
  python_version = var.glue_python_version
  tags           = local.tags
}
