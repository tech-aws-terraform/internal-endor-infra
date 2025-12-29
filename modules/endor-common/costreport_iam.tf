#########################################################
# create IAM role for cross account s3 bucket replication
#########################################################

resource "aws_iam_role" "replication" {

  count = var.cost_bucket_replication ? 1 : 0

  name  = "${local.resource_prefix}-${local.enclave_short_key}-cur-replication-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "replication" {

  count = var.cost_bucket_replication ? 1 : 0

  name  = "${local.resource_prefix}-${local.enclave_short_key}-cur-replication-policy"
  role  = aws_iam_role.replication[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetReplicationConfiguration",
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging",
          "s3:GetObjectRetention",
          "s3:GetObjectLegalHold"
        ]
        Resource = [
          "${concat(module.billing_bucket.*.bucket_arn, [""])[0]}",
          "${concat(module.billing_bucket.*.bucket_arn, [""])[0]}/*",
          "arn:aws:s3:::${var.platform_account_cost_bucket}",
          "arn:aws:s3:::${var.platform_account_cost_bucket}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags",
          "s3:ObjectOwnerOverrideToBucketOwner"
        ]
        Resource = [
          "${concat(module.billing_bucket.*.bucket_arn, [""])[0]}/*",
          "arn:aws:s3:::${var.platform_account_cost_bucket}/*"
        ]
      }
    ]
  })
}
