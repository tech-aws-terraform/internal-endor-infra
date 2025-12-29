#####################
# Local Variables
#####################
locals {
  region_name                 = split("-", var.enclave_region)
  region_short_name           = format("%s%s%s", local.region_name[0], substr(local.region_name[1], 0, 1), substr(local.region_name[2], 0, 1))
  key                         = lower("${var.enclave_key}")
  key_with_underscore         = replace(local.key, "-", "_")

  tags = merge(
    {
      "Enclave"   = "${var.enclave_key}"
    },
  )

  prestaging_bucket_tag = {
    "navify:bucket-phase"    = "prestaging"
  }

  stage_bucket_tag = {
    "navify:bucket-phase"    = "stage"
  }

  ingest_bucket_tag = {
    "navify:bucket-phase"    = "ingest"
  }

  study_sci_ingress_data_bucket_tag = {
    "navify:bucket-phase"    = "study-scientific-ingressed-data"
  }

  study_sup_data_bucket_tag = {
    "navify:bucket-phase"    = "study-supportive-data"
  }

  # S3 Bucket variables
  s3_cors_origins                = ["https://${var.enclave_domain_name}", "https://api.${var.enclave_domain_name}"]
  enclave_root_iam_role          = ["arn:aws:iam::${var.enclave_account_id}:root"]
  enclave_trust_iam_roles        = ["arn:aws:iam::${var.enclave_account_id}:role/${var.enclave_devops_role}", "arn:aws:iam::${var.enclave_account_id}:role/${var.enclave_engg_role}"]
  enclave_root_trust_iam_roles   = ["arn:aws:iam::${var.enclave_account_id}:role/${var.enclave_devops_role}", "arn:aws:iam::${var.enclave_account_id}:role/${var.enclave_engg_role}", "arn:aws:iam::${var.enclave_account_id}:root"]

  prestaging_s3             = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-prestaging-s3"))
  staging_s3                = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-staging-s3"))
  ingest_s3                 = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-ingest-s3"))
  study_sci_ingress_data_s3 = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-study-sci-ingress-data-s3"))
  study_supportive_data_s3  = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-study-supportive-data-s3"))

  transfer_glue_job_name        = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-transfer-glue-etljob"))
  approval_glue_job_name        = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-approval-glue-etljob"))
  ingest_glue_job_name          = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-ingest-glue-etljob"))

  org_cat_fm_glue_job_name             = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-org-cat-fm-glue-etljob"))
  org_cat_data_access_fm_glue_job_name = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-org-cat-data-access-fm-glue-etljob"))
  org_cat_download_glue_job_name       = lower(format("8%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-org-cat-download-glue-etljob"))

  org_catalog_bucket_name       = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-org-catalog-bucket"))

  neptune_opensearch_stream_application_name    = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-neptune-os-stream-app"))
  neptune_opensearch_stream_step_function_name  = lower("${var.enclave_key}-neptune-opensearch-poller-step-funtion")

  # Enclave Specific Glue Job Variables
  enclave_specific_ingest_glue_job_name  = lower(format("%s%s", var.environment, "-${local.region_short_name}-${var.enclave_key}-specific-ingest-glue-etljob"))
  
  # Check if the input contains any hyphens
  contains_hyphen = can(regex("-", var.enclave_key))
  
  # Split the input string into a list of words if it contains a hyphen
  enclave = local.contains_hyphen ? split("-", var.enclave_key) : []
  
  # Extract the first letter of each word and join them if there are multiple words
  enclave_short_key = local.contains_hyphen ? join("", [for word in local.enclave : substr(word, 0, 1)]) : null

   # Cost Dashboard Changes
  resource_prefix   = "${var.environment}-${local.region_short_name}"
  
  # Endor data domain ingestion config details
  create_bucket_notification = var.use_endor_data_domain ? false : true
  ingest_event_rule = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-invoke-transferlambda-rule"))
  transfer_lambda_source_arn = var.use_endor_data_domain ? format("%s%s%s%s%s%s", "arn:aws:events:", var.enclave_region, ":", var.endor_account_id, ":rule/", local.ingest_event_rule) : lower(format("%s", "arn:aws:s3:::*"))
  transfer_lambda_principal  =  var.use_endor_data_domain ? "events.amazonaws.com" : "s3.amazonaws.com"


  #pagination infra details
  upload_paginate_rule = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-prestage-paginate-event-rule"))
  datasync_paginate_rule = lower(format("%s%s%s%s", "${var.environment}-", "${local.region_short_name}-", local.key, "-datasync-paginate-event-rule"))
  paginate_lambda_name = "${var.enclave_key}-pagination-lambda"
  paginate_lambda_arn = lower(format("%s%s%s%s%s%s", "arn:aws:lambda:", var.enclave_region, ":", var.enclave_account_id, ":function:", local.paginate_lambda_name))
}