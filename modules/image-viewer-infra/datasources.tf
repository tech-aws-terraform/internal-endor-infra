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

data "aws_iam_policy_document" "thumbnail_lambda_policy" {
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
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObjectAcl",
      "s3:GetObject",
      "s3:DeleteObjectVersion",
      "s3:DeleteObject",
      "s3:PutObjectAcl",
      "s3:GetObjectVersion"
    ]
    effect    = "Allow"
    resources = ["*"]
    #resources = [format("%s%s", var.prestage_bucket_arn, "/*")]
  }
  statement {
    actions = ["glue:*"]
    effect  = "Allow"
    resources = [
      local.img_glue_job_arn
    ]
  }
}

#thumbnail event rule role policy creation
data "aws_iam_policy_document" "thumbnail_eventrule_role" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["events.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
    # condition {
    #     test     = "ArnEquals"
    #     values   = ["arn:aws:events:us-west-2:376129849625:rule/devtest-usw2-internal-enclave-invoke-imglambda-rule"]
    #     variable = "aws:SourceArn"
    #   }
  }
}

data "aws_iam_policy_document" "thumbnail_eventrule_policy" {
  statement {
    actions = [
      "sqs:SendMessage"
    ]
    effect = "Allow"
    resources = [
      local.enclave_thubmnail_queue1_arn
    ]
  }
}
