locals {
  bucket_metadata_folder   = ["metadata/do_not_archive.kamino"]
}

resource "aws_s3_bucket" "bucket" {
  count         = var.create_bucket ? 1 : 0
  bucket        = var.s3_bucket_name
  force_destroy = var.force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_lifecycle_configuration" "prestage_bucket_lc" {
  count   = var.create_prestage_bucket_lc ? 1 : 0
  bucket  = aws_s3_bucket.bucket[count.index].id

  dynamic "rule" {
    for_each = var.prestaging_bucket_lc_rule
    content {
      id     = rule.value.id
      status = rule.value.enabled ? "Enabled" : "Disabled"

      dynamic "filter" {
        for_each = rule.value.prefix != null || rule.value.tags != null ? [1] : []
        content {
          # dynamic "and" {
          #   for_each = rule.value.prefix != null && rule.value.tags != null ? [1] : []
          #   content {
          #     prefix = rule.value.prefix
          #     tags   = rule.value.tags
          #   }
          # }
          
          dynamic "tag" {
            for_each = rule.value.prefix == null && rule.value.tags != null ? rule.value.tags : {}
            content {
              key   = tag.key
              value = tag.value
            }
          }

          prefix = rule.value.prefix != null && rule.value.tags == null ? rule.value.prefix : null
        }
      }

      expiration {
        days = rule.value.expiration_days
      }

      noncurrent_version_expiration {
        noncurrent_days = rule.value.noncurrent_version_expiration_days
      }
    }
  }

  dynamic "rule" {
    for_each = try(jsondecode(var.partial_upload_cleanup_rules), var.partial_upload_cleanup_rules)

    content {
      id     = lookup(rule.value, "id", null)
      status = lookup(rule.value, "status", null)


      dynamic "abort_incomplete_multipart_upload" {
        for_each = lookup(rule.value, "abort_incomplete_multipart_upload_days", null) != null ? [rule.value.abort_incomplete_multipart_upload_days] : []
        content {
          days_after_initiation = abort_incomplete_multipart_upload.value.days_after_initiation
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [rule]
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket_lc" {
  count   = var.create_bucket_lc ? 1 : 0
  bucket  = aws_s3_bucket.bucket[count.index].id

  dynamic "rule" {
    for_each = var.bucket_lc_rule
    content {
      id     = rule.value.id
      status = rule.value.enabled ? "Enabled" : "Disabled"

      dynamic "filter" {
        for_each = rule.value.prefix != null || rule.value.tags != null ? [1] : []
        content {
          # dynamic "and" {
          #   for_each = rule.value.prefix != null && rule.value.tags != null ? [1] : []
          #   content {
          #     prefix = rule.value.prefix
          #     tags   = rule.value.tags
          #   }
          # }
          
          dynamic "tag" {
            for_each = rule.value.prefix == null && rule.value.tags != null ? rule.value.tags : {}
            content {
              key   = tag.key
              value = tag.value
            }
          }

          prefix = rule.value.prefix != null && rule.value.tags == null ? rule.value.prefix : null
        }
      }
      
      expiration {
        days = rule.value.expiration_days
      }

      noncurrent_version_expiration {
        noncurrent_days = rule.value.noncurrent_version_expiration_days
      }
    }
  }

  dynamic "rule" {
    for_each = try(jsondecode(var.partial_upload_cleanup_rules), var.partial_upload_cleanup_rules)

    content {
      id     = lookup(rule.value, "id", null)
      status = lookup(rule.value, "status", null)


      dynamic "abort_incomplete_multipart_upload" {
        for_each = lookup(rule.value, "abort_incomplete_multipart_upload_days", null) != null ? [rule.value.abort_incomplete_multipart_upload_days] : []
        content {
          days_after_initiation = abort_incomplete_multipart_upload.value.days_after_initiation
        }
      }
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  count         = var.create_bucket ? 1 : 0
  bucket        = aws_s3_bucket.bucket[count.index].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.s3_encryption_type != "default" ? "aws:kms" : "AES256"
      kms_master_key_id = var.s3_encryption_type != "default" ? "${var.kms_key_arn}" : ""
    }
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  count         = var.create_bucket ? 1 : 0
  bucket        = aws_s3_bucket.bucket[count.index].id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_object" "bucket" {
  count        = var.create_bucket_object ? 1 : 0
  bucket       = aws_s3_bucket.bucket[count.index].id
  acl          = var.acl
  key          = local.bucket_metadata_folder[count.index]
  source       = "${path.module}/files/do_not_archive.kamino"
  tags         = {apply_lifecycle_rule = "no"}
  content_type = var.content_type
}

resource "aws_s3_bucket_notification" "bucket" {
  count                 = var.create_bucket_notification ? 1 : 0
  bucket                = aws_s3_bucket.bucket[count.index].id
  lambda_function {
    lambda_function_arn = var.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = var.event_notification_prefix
    filter_suffix       = var.event_notification_suffix
  }
}

resource "aws_s3_bucket_notification" "enable_event_bridge_bucket" {
  count                 = var.enable_event_bridge ? 1 : 0
  bucket                = aws_s3_bucket.bucket[count.index].id
  eventbridge           = true
}

resource "aws_s3_bucket_cors_configuration" "bucket" {
  count                 = var.create_cors_policy ? 1 : 0
  bucket                = aws_s3_bucket.bucket[count.index].id
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST",  "DELETE"]
    allowed_origins = var.s3_cors_origins
    expose_headers  = [ "Access-Control-Allow-Origin"]
  }
}

resource "aws_s3_bucket_policy" "prestage_bucket_policy" {
  count                 = var.create_prestage_bucket_policy ? 1 : 0
  bucket                = aws_s3_bucket.bucket[count.index].id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Id":  "EndorBatchJobAccessPolicy",
    "Statement":  [
      {
        Sid       = "HTTPSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        "Sid":  "BucketFullAccess",
        "Action":  [
          "s3:List*",
          "s3:Get*",
          "s3:Put*",
          "s3:Delete*"
        ],
        "Effect":  "Allow",
        "Resource":  [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/metadata/*",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*"
        ]
        "Principal":  {
          "AWS": "${var.enclave_root_trust_iam_roles}"
        }
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "ingest_bucket_policy" {
  count                 = var.create_ingest_bucket_policy ? 1 : 0
  bucket                = aws_s3_bucket.bucket[count.index].id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Id":  "EndorBatchJobAccessPolicy",
    "Statement":  [
      {
        Sid       = "HTTPSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        "Sid":  "BucketFullAccess for Java service",
        "Action":  [
          "s3:List*",
          "s3:Get*",
          "s3:Put*",
          "s3:Delete*"
        ],
        "Effect":  "Allow",
        "Resource":  [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/metadata/*",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*"
        ]
        "Principal":  {
          "AWS": "${var.enclave_root_trust_iam_roles}"
        }
      },
      {
        "Sid":  "Datasync access for endor stage account",
        "Action":  [
          "s3:List*",
          "s3:Get*",
          "s3:Put*",
          "s3:Delete*"
        ],
        "Effect":  "Allow",
        "Resource":  [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*"
        ]
        "Principal":  {
          "AWS": "${var.datasync_crossaccount_role}"
        }
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "stage_bucket_policy" {
  count                 = var.create_stage_bucket_policy ? 1 : 0
  bucket                = aws_s3_bucket.bucket[count.index].id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Id":  "EndorBatchJobAccessPolicy",
    "Statement":  [
      {
        Sid       = "HTTPSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        "Sid":  "BucketReadWriteAccess",
        "Action":  [
          "s3:List*",
          "s3:Get*",
          "s3:Put*"
        ],
        "Effect":  "Allow",
        "Resource":   "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/metadata/*",
        "Principal":  {
          "AWS": "${var.enclave_trust_iam_roles}"
        }
      },
      {
        "Sid": "BucketReadAccess",
        "Effect": "Allow",
        "Principal": {
          "AWS": "${var.enclave_trust_iam_roles}"
        },
        "Action": [
          "s3:List*",
          "s3:Get*"
        ],
        "Resource": [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "study_sci_bucket_policy" {
  count                 = var.create_study_sci_bucket_policy ? 1 : 0
  bucket                = aws_s3_bucket.bucket[count.index].id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Id":  "ptfmBucketAccessPolicy",
    "Statement":  [
      {
        Sid       = "HTTPSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        "Sid": "BucketFullAccess",
        "Effect": "Allow",
        "Principal": {
          "AWS": "${var.enclave_trust_iam_roles}"
        },
        "Action": ["s3:*"],
        "Resource": [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*",
        ]
      },
      {
        "Sid": "BucketReadAccess",
        "Effect": "Allow",
        "Principal": {
          "AWS": "${var.enclave_root_iam_role}"
        },
        "Action": [
          "s3:List*",
          "s3:Get*",
          "s3:PutBucketNotification"
        ],
        "Resource": [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*",
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "study_support_bucket_policy" {
  count                 = var.create_study_sup_bucket_policy ? 1 : 0
  bucket                = aws_s3_bucket.bucket[count.index].id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Id":  "EndorBatchJobAccessPolicy",
    "Statement":  [
      {
        Sid       = "HTTPSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        "Sid": "BucketFullAccess",
        "Effect": "Allow",
        "Principal": {
          "AWS": "${var.enclave_trust_iam_roles}"
        },
        "Action": [
          "s3:List*",
          "s3:Get*",
          "s3:Put*",
          "s3:Delete*"
        ],
        "Resource": [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*"
        ]
      },
      {
        "Sid": "BucketFullAccess",
        "Effect": "Allow",
        "Principal": {
          "AWS": "${var.enclave_root_iam_role}"
        },
        "Action": [
          "s3:List*",
          "s3:Get*",
          "s3:Put*",
          "s3:Delete*"
        ],
        "Resource": [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_ownership_controls" "bucket_ownership" {
  count  = var.create_bucket_ownership ? 1 : 0
  bucket = aws_s3_bucket.bucket[count.index].id
  rule {
    object_ownership = var.object_ownership
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  count  = var.create_bucket_versioning ? 1 : 0
  bucket = aws_s3_bucket.bucket[count.index].id
  versioning_configuration {
    status = "${var.versioning}"
  }
}

resource "aws_s3_bucket_policy" "org_catalog_bucket_policy" {
  count                 = var.create_org_catalog_bucket_policy ? 1 : 0
  bucket                = aws_s3_bucket.bucket[count.index].id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Id":  "OrgCatalogAccessPolicy",
    "Statement":  [
      {
        Sid       = "HTTPSOnly"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        "Sid":  "BucketFullAccess",
        "Action":  [
          "s3:List*",
          "s3:Get*",
          "s3:Put*",
          "s3:Delete*"
        ],
        "Effect":  "Allow",
        "Resource":  [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/metadata/*",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*"
        ]
        "Principal":  {
          "AWS": "${var.enclave_trust_iam_roles}"
        }
      },
      {
        "Sid": "BucketRootAccess",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::${var.enclave_account_id}:root"
        },
        "Action": [
          "s3:List*",
          "s3:Get*",
          "s3:Put*",
          "s3:Delete*"
        ],
        "Resource": [
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}",
          "${concat(aws_s3_bucket.bucket.*.arn, [""])[0]}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "org_catalog_bucket_notification" {
  count                 = var.create_org_cat_bucket_notification ? 1 : 0
  bucket                = aws_s3_bucket.bucket[count.index].id
  lambda_function {
    lambda_function_arn = var.org_catalog_fm_lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = var.org_catalog_event_notification_prefix
    filter_suffix       = var.org_catalog_event_notification_suffix
  }

  lambda_function {
    lambda_function_arn = var.org_catalog_data_access_fm_lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = var.org_catalog_data_access_event_notification_prefix
    filter_suffix       = var.org_catalog_event_notification_suffix
  }

  lambda_function {
    lambda_function_arn = var.org_catalog_download_lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = var.org_catalog_download_event_notification_prefix
    filter_suffix       = var.org_catalog_event_notification_suffix
  }
}