module "billing_bucket" {
  count                   = var.enable_cur_report ? 1 : 0
  source                  = "../terraform-modules/terraform-aws-s3"

  create_bucket            = true
  s3_bucket_name           = "${local.resource_prefix}-${local.enclave_short_key}-endor-cur-report"
  create_bucket_ownership  = true
  create_bucket_versioning = true
  versioning               = "Enabled"
  enclave_account_id       = var.enclave_account_id
}

# Create the custom policy for billing bucket
resource "aws_s3_bucket_policy" "billing_bucket_policy" {
  count  = var.enable_cur_report ? 1 : 0
  bucket = concat(module.billing_bucket.*.bucket_id, [""])[0]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "HTTPSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${concat(module.billing_bucket.*.bucket_arn, [""])[0]}",
          "${concat(module.billing_bucket.*.bucket_arn, [""])[0]}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        Sid = "EnableAWSDataExportsToWriteToS3AndCheckPolicy"
        Effect = "Allow"
        Principal = {
          Service = [
            "bcm-data-exports.amazonaws.com",
            "billingreports.amazonaws.com"
          ]
        }
        Action = [
          "s3:PutObject",
          "s3:GetBucketPolicy"
        ]
        Resource = [
          "${concat(module.billing_bucket.*.bucket_arn, [""])[0]}",
          "${concat(module.billing_bucket.*.bucket_arn, [""])[0]}/*",
        ]
        Condition = {
          StringLike = {
            "aws:SourceAccount" = data.aws_caller_identity.current.account_id
            "aws:SourceArn" = [
              "arn:aws:cur:us-east-1:${data.aws_caller_identity.current.account_id}:definition/*",
              "arn:aws:bcm-data-exports:us-east-1:${data.aws_caller_identity.current.account_id}:export/*"
            ]
          }
        }
      },
      {
        Sid = "EnforceHTTPSOnly"
        Effect = "Deny"
        Principal = "*"
        Action = "s3:*"
        Resource = [
          "${concat(module.billing_bucket.*.bucket_arn, [""])[0]}",
          "${concat(module.billing_bucket.*.bucket_arn, [""])[0]}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

# Add replication configuration for cost dashbord bucket
resource "aws_s3_bucket_replication_configuration" "replication" {
  count = var.cost_bucket_replication ? 1 : 0

  depends_on = [module.billing_bucket]
  role   = aws_iam_role.replication[0].arn
  bucket = concat(module.billing_bucket.*.bucket_id, [""])[0]

  rule {
    id = "ReplicationToPlatform"

    filter {
      prefix = "billing-reports/${data.aws_caller_identity.current.account_id}/"
    }

    status = "Enabled"
    delete_marker_replication {
      status = "Enabled"
    }

    destination {
      bucket        = "arn:aws:s3:::${var.platform_account_cost_bucket}"
      account       = var.platform_account_id
      storage_class = "STANDARD"

      access_control_translation {
        owner = "Destination"
      }
    }
  }
}