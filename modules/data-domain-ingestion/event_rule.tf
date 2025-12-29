module "endor_ingest_event_rule" {
  count              = var.use_endor_data_domain ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-eventbridge"
  event_rule_name    = local.endor_ingest_event_rule
  description        = "Event rule for triggering endor sqs"
  event_rule_pattern = {
    "source" : ["aws.s3"],
    "detail-type" : ["Object Created"],
    "detail" : {
      "bucket" : {
        "name" :  ["${var.ingest_bucket_id}"]
      },
      "object" : {
        "key" : [
          {
            "wildcard" : "metadata/*.json"
          }
        ]
      }
    }
  }
  event_target_id = "SendToSQS"
  target_arn      = module.sqs_queue.sqs_queue_arn
  tags            = local.tags
  depends_on      = [module.sqs_queue]
}


module "transfer_lambda_trig_rule" {
  count              =  var.use_endor_data_domain  ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-eventbridge"
  event_rule_name    = local.transfer_lambda_invokerule_name
  description        = "Event rule for triggering transfer lambda"
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
            "wildcard" : "metadata/*.json"
          }
        ]
      }
    }
  }
  event_target_id = "SendToLambda"
  target_arn      = var.transfer_lambda_arn
  tags            = local.tags
}