######################
# AWS Caller Identity
######################
data "aws_caller_identity" "current" {}


#paginate event rule role policy creation
data "aws_iam_policy_document" "paginate_eventrule_role" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["events.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "paginate_eventrule_policy" {
  statement {
    actions = [
      "lambda:InvokeFunction"
    ]
    effect = "Allow"
    resources = [
      local.paginate_lambda_arn
    ]
  }
}
