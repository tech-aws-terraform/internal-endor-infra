module "img_lambda_event_rule" {
  count              = var.create_image_infra ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-eventbridge"
  event_rule_name    = local.img_lambda_event_rule
  description        = "Event rule for triggering thumbnail img lambda"
  event_rule_pattern = {
    "source" : ["aws.s3"],
    "detail-type" : ["Object Created"],
    "detail" : {
      "bucket" : {
        "name" : ["${var.prestage_bucket_id}"]
      },
      "object" : {
        "key" : [
          {
            "wildcard" : "*.bif"
          }, {
            "wildcard" : "*.tiff"
          },
          {
            "wildcard" : "*.tif"
          }, {
            "wildcard" : "*.svs"
          }
        ]
      }
    }
  }
  event_target_id = "SendToLambda"
  target_arn      = concat(module.thumbnail_lambda.*.lambda_arn, [""])[0]
  tags            = local.tags
}


## created 2 rules for datasync/ folder as we are getting the below error while adding all the 4 wildcard filters in one rule.
## ERROR MSG::  Event pattern is not valid. Reason: Rule is too complex - try using fewer wildcard characters or fewer repeating character sequences after a wildcard character

module "datasync_img_lambda_event_rule1" {
  count              = var.create_image_infra ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-eventbridge"
  event_rule_name    = local.datasync_thumb_img_rule1
  description        = "Event rule for triggering thumbnail img lambda from datasync"
  event_rule_pattern = {
    "source" : ["aws.s3"],
    "detail-type" : ["Object Created"],
    "detail" : {
      "bucket" : {
        "name" : ["${var.ingest_bucket_id}"]
      },
      "object" : {
        "key" : [
          {
            "wildcard" : "*/datasync/*.bif"
          },
          {
            "wildcard" : "*/datasync/*.tif"
          }
        ]
      }
    }
  }
  event_target_id = "SendToLambda"
  target_arn      = concat(module.thumbnail_lambda.*.lambda_arn, [""])[0]
  tags            = local.tags
}


module "datasync_img_lambda_event_rule2" {
  count              = var.create_image_infra ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-eventbridge"
  event_rule_name    = local.datasync_thumb_img_rule2
  description        = "Event rule for triggering thumbnail img lambda from datasync"
  event_rule_pattern = {
    "source" : ["aws.s3"],
    "detail-type" : ["Object Created"],
    "detail" : {
      "bucket" : {
        "name" : ["${var.ingest_bucket_id}"]
      },
      "object" : {
        "key" : [
          {
            "wildcard" : "*/datasync/*.tiff"
          },
          {
            "wildcard" : "*/datasync/*.svs"
          }
        ]
      }
    }
  }
  event_target_id = "SendToLambda"
  target_arn      = concat(module.thumbnail_lambda.*.lambda_arn, [""])[0]
  tags            = local.tags
}

# module "ingestion_event_rule" {
#   count              = var.create_image_infra ? 1 : 0
#   source             = "../terraform-modules/common-modules/terraform-aws-eventbridge"
#   event_rule_name    = local.ingest_event_rule
#   description        = "Event rule for triggering transfer lambda"
#   event_rule_pattern = {
#     "source" : ["aws.s3"],
#     "detail-type" : ["Object Created"],
#     "detail" : {
#       "bucket" : {
#         "name" : ["${var.prestage_bucket_id}"]
#       },
#       "object" : {
#         "key" : [
#           {
#             "wildcard" : "metadata/*.json"
#           }
#         ]
#       }
#     }
#   }
#   event_target_id = "SendToLambda"
#   target_arn      = var.transfer_lambda_arn
#   tags            = local.tags
# }