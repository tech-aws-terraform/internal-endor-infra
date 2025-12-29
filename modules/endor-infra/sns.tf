resource "aws_sns_topic" "topic" {
  count = var.use_endor_data_domain ? 0 : 1
  name = "${var.enclave_key}-ingest-topic"
}

resource "aws_sns_topic_policy" "topic" {
  count  = var.use_endor_data_domain ? 0 : 1
  arn = aws_sns_topic.topic[count.index].arn

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__default_statement_ID",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "SNS:Publish",
        "SNS:RemovePermission",
        "SNS:SetTopicAttributes",
        "SNS:DeleteTopic",
        "SNS:ListSubscriptionsByTopic",
        "SNS:GetTopicAttributes",
        "SNS:AddPermission",
        "SNS:Subscribe"
      ],
      "Resource": "${aws_sns_topic.topic[count.index].arn}",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "${module.ingest_bucket.bucket_arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sns_topic_subscription" "topic" {
  #create topic only if enclave specific resource is required
  count         = var.enclave_specific_resource ? 1 : 0
  topic_arn     = aws_sns_topic.topic[count.index].arn
  protocol      = "lambda"
  endpoint      = module.ingest_lambda[count.index].lambda_arn
  filter_policy_scope = "MessageBody"
  filter_policy = jsonencode({
    "Records": {
      "s3": {
        "object": {
          "key": [
            {
              "prefix": "metadata/"
            }
          ]
        }
      }
    }
  })
}

resource "aws_sns_topic_subscription" "sync_folder_subscription" {
  count         = var.enclave_specific_resource ? 1 : 0
  topic_arn     = aws_sns_topic.topic[count.index].arn
  protocol      = "lambda"
  endpoint      = module.enclave_specific_ingest_lambda[count.index].lambda_arn
  filter_policy_scope = "MessageBody"
  filter_policy = jsonencode({
    "Records": {
      "s3": {
        "object": {
          "key": [
            {
              "prefix": "*/s3sync/"
            },
            {
              "prefix": "*/datasync/"
            }
          ]
        }
      }
    }
  })
}