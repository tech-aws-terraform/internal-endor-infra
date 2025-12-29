data "aws_iam_policy_document" "endor_ingest_sqs_policy" {
  statement {
    actions = [
      "SQS:*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.endor_account_id}:root"]
    }

    effect = "Allow"
    resources = [
      local.endor_ingest_sqs_arn
    ]
  }
  statement {
    actions = [
      "sqs:SendMessage"
    ]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    condition {
      test     = "ArnEquals"
      values   = [local.endor_ingest_event_arn]
      variable = "aws:SourceArn"
    }
    resources = [
      local.endor_ingest_sqs_arn
    ]
  }
}

data "aws_iam_policy_document" "endor_ingest_lambda_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup"
    ]
    effect = "Allow"
    resources = [
      local.log_account_arn
    ]
  }
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect = "Allow"
    resources = [
      local.log_account_lambda_arn
    ]
  }
  statement {
    actions = [
      "sqs:GetQueueUrl",
      "sqs:ListDeadLetterSourceQueues",
      "sqs:ListMessageMoveTasks",
      "sqs:ReceiveMessage",
      "sqs:GetQueueAttributes",
      "sqs:ListQueueTags",
      "sqs:DeleteMessage"
    ]
    effect    = "Allow"
    resources = [local.endor_ingest_sqs_arn]
  }
  statement {
    actions = [
      "batch:SubmitJob",
      "batch:DescribeJobs",
      "batch:TerminateJob"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:batch:${var.enclave_region}:${var.endor_account_id}:job-definition/${local.batch_job_def_name}*",
      "arn:aws:batch:${var.enclave_region}:${var.endor_account_id}:job-queue/${local.batch_job_queue_name}",
      "arn:aws:batch:${var.enclave_region}:${var.endor_account_id}:job/*"
    ]
  }

  statement {
    actions = [
      "iam:PassRole"
    ]
    effect    = "Allow"
    resources = ["arn:aws:iam::${var.endor_account_id}:role/${local.batch_task_exec_role}"]
  }

  statement {
    actions = [
      "ssm:PutParameter",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:GetParametersByPath"
    ]
    effect    = "Allow"
    resources = ["arn:aws:ssm:${var.enclave_region}:${var.endor_account_id}:parameter/*"]
  }
}


data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "batch_service_assume_role" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["batch.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

#allow pull image access from devops prod account
data "aws_iam_policy_document" "ecs_task_exec_policy" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]
    effect    = "Allow"
    resources = ["${local.batch_job_ecr_repo_arn}/*"]
    #["arn:aws:ecr:eu-central-1:195227247767:repository/*"] 
  }
  statement {
    actions   = ["sqs:*"]
    effect    = "Allow"
    resources = ["${var.ingest_status_sqs_arn}"]
  }
  statement {
    actions = [
      "kms:*"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  # statement {
  #   actions = [
  #     "ssm:PutParameter",
  #     "ssm:GetParameter"
  #   ]
  #   effect = "Allow"
  #   resources = [
  #     "${local.ssm_param_arn}"
  #   ]
  # }
}



data "aws_iam_policy_document" "ingest_feedback_sqs_policy" {
  statement {
    actions = [
      "SQS:*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.endor_account_id}:root"]
    }

    effect = "Allow"
    resources = [
      local.ingest_feedbck_sqs_arn
    ]
  }
  statement {
    actions = [
      "SQS:*"
    ]
    principals {
      type        = "AWS"
      identifiers = local.enclave_trust_iam_roles
    }

    effect = "Allow"
    resources = [
      local.ingest_feedbck_sqs_arn
    ]
  }
}

data "aws_dynamodb_table" "endor_dynamodb_stream"{
    name = var.endor_catalog_table_name
}

data "aws_iam_policy_document" "feedback_pipe_assume_role" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["pipes.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
    statement {
    effect = "Allow"
    principals {
      identifiers = local.enclave_trust_iam_roles
      type        = "AWS"
    }
    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "feedback_pipe_policy" {
  statement {
    actions = [
      "sqs:SendMessage",
      "sqs:ReceiveMessage"
    ]
    effect = "Allow"
    resources = [
      local.ingest_feedbck_sqs_arn
    ]
  }
  statement {
    actions = [
        "dynamodb:DescribeStream",
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator",
        "dynamodb:ListStreams"
    ]
    effect = "Allow"
    resources = [
      #"*"
      local.endor_dynamo_db_stream_arn
    ]
  }
  statement {
    actions = [
      "pipes:*"
    ]
    effect = "Allow"
    resources = [
      local.ingest_event_pipe_sqs_arn
    ]
  }

}



# data "aws_iam_policy_document" "event_pipe_assume_role" {
#   statement {
#     effect = "Allow"
#     principals {
#       identifiers = ["pipes.amazonaws.com"]
#       type        = "Service"
#     }
#     actions = ["sts:AssumeRole"]
#   }
# }


# data "aws_iam_policy_document" "event_pipe_policy" {
#   statement {
#     actions = [
#       "sqs:ReceiveMessage",
#       "sqs:DeleteMessage",
#       "sqs:GetQueueAttributes"
#     ]
#     effect = "Allow"
#     resources = [
#       local.endor_ingest_sqs_arn
#     ]
#   }
#   statement {
#     actions = [
#       "states:*"
#     ]
#     effect = "Allow"
#     resources = [
#       "*"
#     ]
#   }
#   # statement {
#   #   actions = [
#   #     "logs:*"
#   #   ]
#   #   effect = "Allow"
#   #   resources = [
#   #     "*"
#   #   ]
#   # }
# }


# data "aws_iam_policy_document" "step_func_assume_role" {
#   statement {
#     effect = "Allow"
#     principals {
#       identifiers = ["states.amazonaws.com"]
#       type        = "Service"
#     }
#     actions = ["sts:AssumeRole"]
#   }
# }

# data "aws_iam_policy_document" "step_func_policy" {
#   statement {
#     actions = [
#       "lambda:InvokeFunction"
#     ]
#     effect = "Allow"
#     resources = [
#       local.endor_ingest_lambda_arn
#     ]
#   }
#   statement {
#     actions = [
#       "lambda:InvokeFunction"
#     ]
#     effect = "Allow"
#     resources = [
#       "${local.endor_ingest_lambda_arn}:*"
#     ]
#   }
#   statement {
#     actions = [
#       "ssm:PutParameter",
#       "ssm:GetParameter"
#     ]
#     effect = "Allow"
#     resources = [
#       "${local.ssm_param_arn}"
#     ]
#   }
#   statement {
#     actions = [
#       "xray:PutTraceSegments",
#       "xray:PutTelemetryRecords",
#       "xray:GetSamplingRules",
#       "xray:GetSamplingTargets"
#     ]
#     effect    = "Allow"
#     resources = ["*"]
#   }
# }
