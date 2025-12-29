module "roles_policies" {
  source                      = "../terraform-modules/terraform-aws-iam-role"
  create_roles_policies       = var.create_roles_policies
  enclave_specific_resource   = var.enclave_specific_resource
  log_account_arn             = format("%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":*")

  ##### Auth Lambda Role & Policy #####
  auth_lambda_iam_role_name   = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-kamino-${local.key}-auth-lambda-role"))
  auth_lambda_policy_name     = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-kamino-${local.key}-auth-lambda-policy"))
  log_account_auth_lambda_arn = format("%s%s%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":log-group:/aws/lambda/", lower("${local.key}-auth-lambda"), ":*")

  ##### Transfer Lambda Role & Policy #####
  transfer_lambda_iam_role_name   = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-transfer-lambda-role"))
  transfer_lambda_policy_name     = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-transfer-lambda-policy"))
  log_account_transfer_lambda_arn = format("%s%s%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":log-group:/aws/lambda/", lower("${local.key}-transfer-lambda"), ":*")

  ##### Approval Lambda Role & Policy #####
  approval_lambda_iam_role_name   = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-approval-lambda-role"))
  approval_lambda_policy_name     = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-approval-lambda-policy"))
  log_account_approval_lambda_arn = format("%s%s%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":log-group:/aws/lambda/", lower("${local.key}-approval-lambda"), ":*")

  ##### Ingestion Lambda Role & Policy #####
  ingest_lambda_iam_role_name      = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-ingest-lambda-role"))
  ingest_lambda_policy_name        = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-ingest-lambda-policy"))
  log_account_ingest_lambda_arn    = format("%s%s%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":log-group:/aws/lambda/", lower("${local.key}-ingest-lambda"), ":*")

  ##### Provider Role for Enclave #####
  enclave_infra_build_role         = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-study-infra-build-role"))
  enclave_infra_build_policy       = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-iam-engineering-policy"))
  enclave_trust_iam_roles          = local.enclave_trust_iam_roles

  ##### Appsync Roles and Policies #####
  /*appsync_dynamodb_role_name           = lower(format("%s%s%s", "R", local.region_short_name, "_enclave_appsync_dynamodb"))
  appsync_dynamodb_policy_name         = lower(format("%s%s%s", "P", local.region_short_name, "_enclave_appsync_dynamodb"))
  dynamodb_table_arn                   = module.dynamodb_table.dynamodb_table_arn
  appsync_cw_role_name                 = lower(format("%s%s%s", "R", local.region_short_name, "_enclave_appsync_cw"))
  appsync_admin_service_http_role_name = lower(format("%s%s%s", "R", local.region_short_name, "_enclave_appsync_http"))*/

  ##### Glue job ARN #####
  # transfer_glue_job_arn                = concat(module.transfer_glue.*.glue_etl_job_arn, [""])[0]
  # approval_glue_job_arn                = concat(module.approval_glue.*.glue_etl_job_arn, [""])[0]
  # ingest_glue_job_arn                  = concat(module.ingest_glue.*.glue_etl_job_arn, [""])[0]

  ###### API GW Log #####
  apigw_cw_role_name           = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-apigw-cw-role"))
  apigw_cw_policy_name         = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-apigw-cw-policy"))

  ##### Org Catalog Lambda Role & Policy, Glue ARN #####
  create_org_catalog                       = var.create_org_catalog
  org_catalog_fm_lambda_iam_role_name      = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-org-cat-fm-lambda-role"))
  org_catalog_fm_lambda_policy_name        = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-org-cat-fm-lambda-policy"))
  log_account_org_catalog_fm_lambda_arn    = format("%s%s%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":log-group:/aws/lambda/", lower("${local.key}-org-cat-fm-lambda"), ":*")

  org_catalog_fm_glue_job_arn              = concat(module.org_catalog_fm_glue.*.glue_etl_job_arn, [""])[0]

  ##### Org Catalog Data Access Lambda Role & Policy, Glue ARN #####
  org_catalog_data_access_fm_lambda_iam_role_name   = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-org-cat-da-fm-lambda-role"))
  org_catalog_data_access_fm_lambda_policy_name     = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-org-cat-da-fm-lambda-policy"))
  log_account_org_catalog_data_access_fm_lambda_arn = format("%s%s%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":log-group:/aws/lambda/", lower("${local.key}-org-cat-da-fm-lambda"), ":*")

  org_catalog_data_access_fm_glue_job_arn           = concat(module.org_catalog_data_access_fm_glue.*.glue_etl_job_arn, [""])[0]

  ##### Org Catalog Download Lambda Role & Policy, Glue ARN #####
  org_catalog_download_lambda_iam_role_name     = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-org-cat-download-lambda-role"))
  org_catalog_download_lambda_policy_name       = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-org-cat-download-lambda-policy"))
  log_account_org_catalog_download_lambda_arn   = format("%s%s%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":log-group:/aws/lambda/", lower("${local.key}-org-cat-download-lambda"), ":*")

  org_catalog_download_glue_job_arn             = concat(module.org_catalog_download_glue.*.glue_etl_job_arn, [""])[0]

  ##### Neptune Opensearch Stream Duplicate Execution check Lambda IAM Role & Policy #####
  neptune_duplicate_execution_check_lambda_iam_role_name = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-nt-dup-exec-check-lambda-role"))
  neptune_duplicate_execution_check_lambda_policy_name   = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-nt-dup-exec-check-lambda-policy"))
  lease_db_table_arn                                     = concat(module.neptune_opensearch_poller_dynamodb_table.*.lease_dynamodb_table_arn, [""])[0]

  ##### Neptune Opensearch Stream Restart Statemachine Lambd IAM Role & Policy #####
  neptune_restart_statemachine_lambda_iam_role_name = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-nt-restart-sm-lambda-role"))
  neptune_restart_statemachine_lambda_policy_name   = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-nt-restart-sm-lambda-policy"))

  ##### Neptune Opensearch Stream Poller Step Function IAM Role & Policy #####
  neptune_stream_poller_step_function_iam_role_name = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-nt-stream-poller-sf-role"))
  neptune_stream_poller_step_function_policy_name   = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-nt-stream-poller-sf-policy"))

  # Enclave Specific Resources
  ##### Ingestion Lambda Role & Policy #####
  enclave_specific_ingest_lambda_iam_role_name      = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${local.key}-specific-ingest-lambda-role"))
  enclave_specific_ingest_lambda_policy_name        = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${local.key}-specific-ingest-lambda-policy"))
  enclave_specific_log_account_ingest_lambda_arn    = format("%s%s%s%s%s%s%s", "arn:aws:logs:", var.enclave_region, ":", var.endor_account_id, ":log-group:/aws/lambda/", lower("${local.key}-specific-ingest-lambda"), ":*")

  enclave_specific_ingest_glue_job_arn              = concat(module.enclave_specific_ingest_glue.*.glue_etl_job_arn, [""])[0]

  tags = local.tags
}

module "glue_job_roles_policies" {
  source                               = "../terraform-modules/terraform-aws-iam-role"
  create_glue_job_roles_policies       = var.create_glue_job_roles_policies
  glue_job_role_name                   = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-endor-glue-role"))
  glue_job_cw_metric_policy_name       = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-endor-cw-metric-policy"))
  glue_job_dynamodb_policy_name        = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-enclave-endor-dynamodb-policy"))

  dynamodb_table_arn                   = module.dynamodb_table.dynamodb_table_arn

  tags = local.tags
}

module "study_roles_policies" {
  source                                   = "../terraform-modules/terraform-aws-iam-role"
  create_study_roles_policies              = var.create_study_roles_policies
  study_invoke_api_role_name               = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-sftp-api-invoke-role"))
  study_invoke_api_policy_name             = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-sftp-api-invoke-policy"))
  region                                   = var.enclave_region
  endor_account_id                         = var.endor_account_id
  apigw_id                                 = concat(module.api_gateway.*.transfer_secure_api_id, [""])[0]

  tags = local.tags

  depends_on                               = [module.prestage_bucket]
}

########## Neptune Opensearch Stream Poller Lambda IAM ROLES & POLICIES ##########
module "neptune_opensearch_poller_iam_roles_policies" {
  source                               = "../terraform-modules/terraform-aws-iam-role"
  create_neptune_opensearch_stream_poller_lambda_iam_roles_policies   = var.create_org_catalog
  neptune_opensearch_stream_poller_lambda_iam_role_name = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-nt-os-stream-poller-lambda-role"))
  neptune_opensearch_stream_poller_lambda_policy_name   = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-nt-os-stream-poller-lambda-policy"))
  neptune_db_arn                                        = concat(module.neptune_clusters.*.neptune_cluster_arn, [""])[0]
  lease_db_table_arn                                    = concat(module.neptune_opensearch_poller_dynamodb_table.*.lease_dynamodb_table_arn, [""])[0]

  tags                                 = local.tags

  depends_on = [module.neptune_clusters ]
}

#pagination event role
module "paginate_eventrule_roles_policies" {
  count              = var.create_pagination_infra ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-iam-role"
  role_name          = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-paginate-event-role"))
  policy_name        = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-paginate-event-policy"))
  assume_role_policy = data.aws_iam_policy_document.paginate_eventrule_role.json
  policy             = data.aws_iam_policy_document.paginate_eventrule_policy.json
  tags               = local.tags
}

# budget role 
resource "aws_iam_role" "budget" {

  count = var.enable_budget ? 1 : 0

  name  = "${local.resource_prefix}-${local.enclave_short_key}-budget-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "budgets.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      },
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": [
            "arn:aws:iam::${var.enclave_account_id}:role/${var.enclave_devops_role}"
          ]
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "budget" {

  count = var.enable_budget ? 1 : 0

  name  = "${local.resource_prefix}-${local.enclave_short_key}-budget-policy"
  role  = aws_iam_role.budget[0].id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "budgets:ViewBudget",
          "budgets:ModifyBudget"
        ],
        "Resource": "*",
        "Condition": {
          "StringEquals": {
            "aws:ResourceTag/platform": "${var.platform}"
          }
        }
      }
    ]
  })
}