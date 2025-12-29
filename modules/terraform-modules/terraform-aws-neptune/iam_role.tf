data "aws_iam_policy_document" "neptune" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }
  }

  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = var.enclave_trust_iam_roles
    }
  }
}

resource "aws_iam_role" "neptune" {
  name                 = var.neptune_role_name
  assume_role_policy   = data.aws_iam_policy_document.neptune.json
  description          = var.neptune_role_description
  permissions_boundary = var.neptune_role_permissions_boundary

  tags = merge(
    {
      "Name" = format("%s", var.neptune_role_name)
    },
    var.tags,
  )
}

resource "aws_iam_role_policy" "neptune" {
  name  = var.neptune_policy_name
  role  = aws_iam_role.neptune.id
  policy = templatefile("${path.module}/templates/iam_authentication.tpl", {
    org_neptune_s3_bucket_arn = var.org_neptune_s3_bucket_arn
    account_id                = var.account_id
    region                     = var.region
  })
}

resource "aws_iam_role" "notebook" {
  name               = var.neptune_sagemaker_role_name #"${var.enclave_key}-neptune-notebook"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "sagemaker.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = merge({ "Name" = "${var.enclave_key}-neptune-notebook" }, var.tags)
}

resource "aws_iam_role_policy" "notebook" {
  name  = var.neptune_sagemaker_policy_name #"${var.enclave_key}-neptune-notebook"
  role  = aws_iam_role.notebook.id
  policy = templatefile("${path.module}/templates/neptune_notebook.tpl", {
    org_neptune_s3_bucket_arn  = var.org_neptune_s3_bucket_arn,
    region                     = var.region,
    account                    = data.aws_caller_identity.this.account_id,
    org_neptune_cluster_res_id = aws_neptune_cluster.this.cluster_resource_id
  })
}
