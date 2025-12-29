locals {
  auth_lambda_iam_role_name           = var.auth_lambda_iam_role_name
  transfer_lambda_iam_role_name       = var.transfer_lambda_iam_role_name
  approval_lambda_iam_role_name       = var.approval_lambda_iam_role_name
  ingest_lambda_iam_role_name         = var.ingest_lambda_iam_role_name
  enclave_infra_build_role            = var.enclave_infra_build_role

  org_catalog_fm_lambda_iam_role_name             = var.org_catalog_fm_lambda_iam_role_name
  org_catalog_data_access_fm_lambda_iam_role_name = var.org_catalog_data_access_fm_lambda_iam_role_name
  org_catalog_download_lambda_iam_role_name       = var.org_catalog_download_lambda_iam_role_name

  neptune_duplicate_execution_check_lambda_iam_role_name  = var.neptune_duplicate_execution_check_lambda_iam_role_name
  neptune_opensearch_stream_poller_lambda_iam_role_name   = var.neptune_opensearch_stream_poller_lambda_iam_role_name
  neptune_restart_statemachine_lambda_iam_role_name       = var.neptune_restart_statemachine_lambda_iam_role_name
  neptune_stream_poller_step_function_iam_role_name       = var.neptune_stream_poller_step_function_iam_role_name

  # Enclave Specific Resources
  enclave_specific_ingest_lambda_iam_role_name  = var.enclave_specific_ingest_lambda_iam_role_name
}

########## Auth Lambda Role ##########
resource "aws_iam_role" "auth_lambda_iam_role" {
  count                = var.create_roles_policies ? 1 : 0
  name                 = local.auth_lambda_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

########## Auth Lambda Policy ##########
resource "aws_iam_role_policy" "auth_lambda_iam_policy" {
  count = var.create_roles_policies ? 1 : 0
  name  = var.auth_lambda_policy_name
  role  = aws_iam_role.auth_lambda_iam_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_auth_lambda.tpl", {
    log_account_arn             = var.log_account_arn,
    log_account_auth_lambda_arn = var.log_account_auth_lambda_arn
  })
}

########## Auth Lambda Policy ##########
resource "aws_iam_role_policy_attachment" "auth_lambda_iam_policy_attach" {
  for_each = var.create_roles_policies ? toset([
    "arn:aws:iam::aws:policy/AWSTransferReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess"
  ]) :[]
  role       = aws_iam_role.auth_lambda_iam_role[0].id
  policy_arn = each.value
}

########## Transfer Lambda Role ##########
resource "aws_iam_role" "transfer_lambda_iam_role" {
  count                = var.create_roles_policies ? 1 : 0
  name                 = local.transfer_lambda_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

########## Transfer Lambda Policy ##########
resource "aws_iam_role_policy" "transfer_lambda_iam_policy" {
  count = var.create_roles_policies ? 1 : 0
  name  = var.transfer_lambda_policy_name
  role  = aws_iam_role.transfer_lambda_iam_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_transfer_lambda.tpl", {
    log_account_arn                 = var.log_account_arn,
    log_account_transfer_lambda_arn = var.log_account_transfer_lambda_arn
    #transfer_glue_job_arn           = var.transfer_glue_job_arn
  })
}

########## Transfer Lambda Policy Attachement ##########
resource "aws_iam_role_policy_attachment" "transfer_lambda_iam_policy_attach" {
  for_each = var.create_roles_policies ? toset([
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
  ]) :[]
  role       = aws_iam_role.transfer_lambda_iam_role[0].id
  policy_arn = each.value
}

########## Approval Lambda Role ##########
resource "aws_iam_role" "approval_lambda_iam_role" {
  count                = var.create_roles_policies ? 1 : 0
  name                 = local.approval_lambda_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

########## Approval Lambda Policy ##########
resource "aws_iam_role_policy" "approval_lambda_iam_policy" {
  count = var.create_roles_policies ? 1 : 0
  name  = var.approval_lambda_policy_name
  role  = aws_iam_role.approval_lambda_iam_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_approval_lambda.tpl", {
    log_account_arn                 = var.log_account_arn,
    log_account_approval_lambda_arn = var.log_account_approval_lambda_arn
#    approval_glue_job_arn           = var.approval_glue_job_arn
  })
}

########## Approval Lambda Policy Attachment ##########
resource "aws_iam_role_policy_attachment" "approval_lambda_iam_policy_attach" {
  for_each = var.create_roles_policies ? toset([
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
  ]) :[]
  role       = aws_iam_role.approval_lambda_iam_role[0].id
  policy_arn = each.value
}

########## Ingest Lambda Role ##########
resource "aws_iam_role" "ingest_lambda_iam_role" {
  count                = var.create_roles_policies ? 1 : 0
  name                 = local.ingest_lambda_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

########## Ingest Lambda Policy ##########
resource "aws_iam_role_policy" "ingest_lambda_iam_policy" {
  count = var.create_roles_policies ? 1 : 0
  name  = var.ingest_lambda_policy_name
  role  = aws_iam_role.ingest_lambda_iam_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_ingest_lambda.tpl", {
    log_account_arn               = var.log_account_arn,
    log_account_ingest_lambda_arn = var.log_account_ingest_lambda_arn
    #ingest_glue_job_arn           = var.ingest_glue_job_arn
  })
}

########## Ingest Lambda Policy Attachment ##########
resource "aws_iam_role_policy_attachment" "ingest_lambda_iam_policy_attach" {
  for_each = var.create_roles_policies ? toset([
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]) :[]
  role       = aws_iam_role.ingest_lambda_iam_role[0].id
  policy_arn = each.value
}

########## ENDOR INFRA BUILD ROLE ##########
resource "aws_iam_role" "enclave_infra_iam_role" {
  count                = var.create_roles_policies ? 1 : 0
  name                 = local.enclave_infra_build_role
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "AWS": "${var.enclave_trust_iam_roles}"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
  tags                 = var.tags
}

########## Endor Infra Policy ##########
resource "aws_iam_role_policy" "enclave_infra_iam_policy" {
  count = var.create_roles_policies ? 1 : 0
  name  = var.enclave_infra_build_policy
  role  = aws_iam_role.enclave_infra_iam_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_enclave_infra.tpl", {
  })
}

resource "aws_iam_role_policy_attachment" "enclave_infra_iam_policy_attach" {
  for_each = var.create_roles_policies ? toset([
    "arn:aws:iam::aws:policy/PowerUserAccess",
    "arn:aws:iam::aws:policy/AWSTransferFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]) :[]
  role       = aws_iam_role.enclave_infra_iam_role[0].id
  policy_arn = each.value
}

########## AppSync DYNAMODB ROLE ##########
/*resource "aws_iam_role" "appsync_dynamodb_role" {
  count = var.create_roles_policies ? 1 : 0
  name  = var.appsync_dynamodb_role_name

  assume_role_policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": [
              "appsync.amazonaws.com",
              "apigateway.amazonaws.com"
            ]
          },
          "Effect": "Allow"
        }
      ]
    }
  )
  tags                 = var.tags
}*/

########## DYNAMODB ROLE POLICY ##########
/*resource "aws_iam_role_policy" "appsync_dynamodb_policy" {
  count = var.create_roles_policies ? 1 : 0
  name  = var.appsync_dynamodb_policy_name
  role  = aws_iam_role.appsync_dynamodb_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_appsync_dynamodb.tpl", {
    dynamodb_table_arn = var.dynamodb_table_arn
  })
}*/

########## APPSYNC CW ROLE ##########
/*resource "aws_iam_role" "appsync_cw_role" {
  count = var.create_roles_policies ? 1 : 0
  name  = var.appsync_cw_role_name

  assume_role_policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "appsync.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}*/

########## APPSYNC CW Policy ##########
/*resource "aws_iam_role_policy_attachment" "appsync_cw_policy" {
  count      = var.create_roles_policies ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppSyncPushToCloudWatchLogs"
  role       = aws_iam_role.appsync_cw_role[count.index].name
}*/

########## ADMIN SERVICE ##########
/*resource "aws_iam_role" "appsync_admin_service_http_role" {
  count = var.create_roles_policies ? 1 : 0
  name  = var.appsync_admin_service_http_role_name

  assume_role_policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": [
              "appsync.amazonaws.com"
            ]
          },
          "Effect": "Allow"
        }
      ]
    }
  )
  tags                 = var.tags
}*/

########## GLUE Job Role ##########
resource "aws_iam_role" "glue_job_iam_role" {
  count                = var.create_glue_job_roles_policies ? 1 : 0
  name                 = var.glue_job_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "glue.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

########## GLUE Job - CW Metric Policy ##########
resource "aws_iam_role_policy" "glue_job_cw_metric_policy" {
  count = var.create_glue_job_roles_policies ? 1 : 0
  name  = var.glue_job_cw_metric_policy_name
  role  = aws_iam_role.glue_job_iam_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_cw_metric.tpl", {
  })
}

########## GLUE - DynamoDB Policy ##########
resource "aws_iam_role_policy" "glue_job_dynamodb_policy" {
  count = var.create_glue_job_roles_policies ? 1 : 0
  name  = var.glue_job_dynamodb_policy_name
  role  = aws_iam_role.glue_job_iam_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_glue_dynamodb.tpl", {
    dynamodb_table_arn = var.dynamodb_table_arn
  })
}

########## GLUE Policy Attachment ##########
resource "aws_iam_role_policy_attachment" "glue_job_policy_attach" {
  for_each = var.create_glue_job_roles_policies ? toset([
    "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]) :[]
  role       = aws_iam_role.glue_job_iam_role[0].id
  policy_arn = each.value
}

########## API Gateway CW ##########
resource "aws_iam_role" "apigw_cw_role" {
  count = var.create_roles_policies ? 1 : 0
  name  = var.apigw_cw_role_name

  assume_role_policy = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": [
              "apigateway.amazonaws.com"
            ]
          },
          "Effect": "Allow"
        }
      ]
    }
  )
  tags                 = var.tags
}

resource "aws_iam_role_policy" "apigw_cw_policy" {
  count = var.create_roles_policies ? 1 : 0
  name  = var.apigw_cw_policy_name
  role  = aws_iam_role.apigw_cw_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_apigw_cw.tpl", {
  })
}

#DEV_1266952_creating-transfer-family-with-waf-apigw starts
########## SFTP - Invoke API Role ##########
resource "aws_iam_role" "study_invoke_api_iam_role" {
  count                = var.create_study_roles_policies ? 1 : 0
  name                 = var.study_invoke_api_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "transfer.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )

  tags                 = var.tags
}

########## SFTP - Invoke API Policy ##########
resource "aws_iam_role_policy" "study_invoke_api_iam_policy" {
  count  = var.create_study_roles_policies ? 1 : 0
  name   = var.study_invoke_api_policy_name
  role   = aws_iam_role.study_invoke_api_iam_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_study_invoke_api.tpl", {
    region            = var.region,
    endor_account_id  = var.endor_account_id,
    apigw_id          = var.apigw_id
  })
}
#DEV_1266952_creating-transfer-family-with-waf-apigw ends

########## Org Catalog Lambda Roles ##########
resource "aws_iam_role" "org_catalog_fm_lambda_iam_role" {
  count                = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name                 = local.org_catalog_fm_lambda_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

resource "aws_iam_role_policy" "org_catalog_fm_lambda_iam_policy" {
  count = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name  = var.org_catalog_fm_lambda_policy_name
  role  = aws_iam_role.org_catalog_fm_lambda_iam_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_org_catalog_fm_lambda.tpl", {
    log_account_arn                       = var.log_account_arn,
    log_account_org_catalog_fm_lambda_arn = var.log_account_org_catalog_fm_lambda_arn,
    org_catalog_fm_glue_job_arn           = var.org_catalog_fm_glue_job_arn
  })
}

resource "aws_iam_role_policy_attachment" "org_catalog_fm_lambda_iam_policy_attach" {
  for_each = var.create_roles_policies && var.create_org_catalog ? toset([
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]) :[]
  role       = aws_iam_role.org_catalog_fm_lambda_iam_role[0].id
  policy_arn = each.value
}

resource "aws_iam_role" "org_catalog_data_access_fm_lambda_iam_role" {
  count                = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name                 = local.org_catalog_data_access_fm_lambda_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

resource "aws_iam_role_policy" "org_catalog_data_access_fm_lambda_iam_policy" {
  count   = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name    = var.org_catalog_data_access_fm_lambda_policy_name
  role    = aws_iam_role.org_catalog_data_access_fm_lambda_iam_role[count.index].id
  policy  = templatefile("${path.module}/templates/policy_org_catalog_data_access_fm_lambda.tpl", {
    log_account_arn                                   = var.log_account_arn,
    log_account_org_catalog_data_access_fm_lambda_arn = var.log_account_org_catalog_data_access_fm_lambda_arn,
    org_catalog_data_access_fm_glue_job_arn           = var.org_catalog_data_access_fm_glue_job_arn
  })
}

resource "aws_iam_role_policy_attachment" "org_catalog_data_access_fm_lambda_iam_policy_attach" {
  for_each = var.create_roles_policies && var.create_org_catalog ? toset([
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]) :[]
  role       = aws_iam_role.org_catalog_data_access_fm_lambda_iam_role[0].id
  policy_arn = each.value
}

resource "aws_iam_role" "org_catalog_download_lambda_iam_role" {
  count                = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name                 = local.org_catalog_download_lambda_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

resource "aws_iam_role_policy" "org_catalog_download_lambda_iam_policy" {
  count   = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name    = var.org_catalog_download_lambda_policy_name
  role    = aws_iam_role.org_catalog_download_lambda_iam_role[count.index].id
  policy  = templatefile("${path.module}/templates/policy_org_catalog_download_lambda.tpl", {
    log_account_arn                             = var.log_account_arn,
    log_account_org_catalog_download_lambda_arn = var.log_account_org_catalog_download_lambda_arn,
    org_catalog_download_glue_job_arn           = var.org_catalog_download_glue_job_arn
  })
}

resource "aws_iam_role_policy_attachment" "org_catalog_download_lambda_iam_policy_attach" {
  for_each = var.create_roles_policies && var.create_org_catalog ? toset([
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]) :[]
  role       = aws_iam_role.org_catalog_download_lambda_iam_role[0].id
  policy_arn = each.value
}

########## Neptune Opensearch Stream Duplicate Execution Check Lambda Role ##########
resource "aws_iam_role" "neptune_duplicate_execution_check_lambda_iam_role" {
  count                = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name                 = local.neptune_duplicate_execution_check_lambda_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

########## Neptune Opensearch Stream Duplicate Execution Check Lambda Policy ##########
resource "aws_iam_role_policy" "neptune_duplicate_execution_check_lambda_iam_policy" {
  count = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name  = var.neptune_duplicate_execution_check_lambda_policy_name
  role  = aws_iam_role.neptune_duplicate_execution_check_lambda_iam_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_neptune_duplicate_execution_check_lambda.tpl", {
    lease_db_table_arn = var.lease_db_table_arn
  })
}

########## Neptune Opensearch Stream Poller Lambda Role ##########
resource "aws_iam_role" "neptune_opensearch_stream_poller_lambda_iam_role" {
  count                = var.create_neptune_opensearch_stream_poller_lambda_iam_roles_policies ? 1 : 0
  name                 = local.neptune_opensearch_stream_poller_lambda_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

########## Neptune Opensearch Stream Poller Lambda Policy ##########
resource "aws_iam_role_policy" "neptune_opensearch_stream_poller_lambda_iam_policy" {
  count   = var.create_neptune_opensearch_stream_poller_lambda_iam_roles_policies ? 1 : 0
  name    = var.neptune_opensearch_stream_poller_lambda_policy_name
  role    = aws_iam_role.neptune_opensearch_stream_poller_lambda_iam_role[count.index].id
  policy  = templatefile("${path.module}/templates/policy_neptune_opensearch_stream_poller_lambda.tpl", {
    neptune_db_arn        = var.neptune_db_arn
    lease_db_table_arn    = var.lease_db_table_arn
  })
}

########## Neptune Restart StateMachine Lambda Role ##########
resource "aws_iam_role" "neptune_restart_statemachine_lambda_iam_role" {
  count                = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name                 = local.neptune_restart_statemachine_lambda_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

########## Neptune Restart StateMachine Lambda Policy ##########
resource "aws_iam_role_policy" "neptune_restart_statemachine_lambda_iam_policy" {
  count   = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name    = var.neptune_restart_statemachine_lambda_policy_name
  role    = aws_iam_role.neptune_restart_statemachine_lambda_iam_role[count.index].id
  policy  = templatefile("${path.module}/templates/policy_neptune_restart_state_machine_lambda.tpl", {})
}

########## Neptune Opensearch Stream Poller Step Function Role ##########
resource "aws_iam_role" "neptune_stream_poller_step_function_iam_role" {
  count                = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name                 = local.neptune_stream_poller_step_function_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "states.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

########## Neptune Opensearch Stream Poller Step Function Policy ##########
resource "aws_iam_role_policy" "neptune_stream_poller_step_function_iam_policy" {
  count   = var.create_roles_policies && var.create_org_catalog ? 1 : 0
  name    = var.neptune_stream_poller_step_function_policy_name
  role    = aws_iam_role.neptune_stream_poller_step_function_iam_role[count.index].id
  policy  = templatefile("${path.module}/templates/policy_neptune_opensearch_poller_step_function.tpl", {})
}

# Enclave Specific Resources
########## Ingest Lambda Role ##########
resource "aws_iam_role" "enclave_specific_ingest_lambda_iam_role" {
  count                = var.create_roles_policies && var.enclave_specific_resource ? 1 : 0
  name                 = local.enclave_specific_ingest_lambda_iam_role_name
  max_session_duration = var.role_max_session_duration
  assume_role_policy   = jsonencode(
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "lambda.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
  )
  tags                 = var.tags
}

########## Ingest Lambda Policy ##########
resource "aws_iam_role_policy" "enclave_specific_ingest_lambda_iam_policy" {
  count = var.create_roles_policies && var.enclave_specific_resource ? 1 : 0
  name  = var.enclave_specific_ingest_lambda_policy_name
  role  = aws_iam_role.enclave_specific_ingest_lambda_iam_role[count.index].id
  policy = templatefile("${path.module}/templates/policy_enclave_specific_ingest_lambda.tpl", {
    log_account_arn               = var.log_account_arn,
    log_account_ingest_lambda_arn = var.enclave_specific_log_account_ingest_lambda_arn,
    enclave_specific_ingest_glue_job_arn           = var.enclave_specific_ingest_glue_job_arn
  })
}

########## Ingest Lambda Policy Attachment ##########
resource "aws_iam_role_policy_attachment" "enclave_specific_ingest_lambda_iam_policy_attach" {
  for_each = var.create_roles_policies && var.enclave_specific_resource ? toset([
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]) :[]
  role       = aws_iam_role.enclave_specific_ingest_lambda_iam_role[0].id
  policy_arn = each.value
}