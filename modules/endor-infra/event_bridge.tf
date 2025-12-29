module "neptune_opensearch_poller_event_bridge" {
  source                                              = "../terraform-modules/terraform-aws-event-bridge"
  count                                               = var.create_org_catalog ? 1 : 0
  neptune_opensearch_stream_application_name          = local.neptune_opensearch_stream_application_name
  neptune_stream_poller_state_machine_arn             = concat(module.neptune_opensearch_poller_step_function.*.neptune_stream_poller_state_machine_arn, [""])[0]
  neptune_stream_poller_event_bridge_iam_role_name    = can(regex("-", var.enclave_key)) ? lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${local.enclave_short_key}-neptune-stream-poller-event-bridge-role")) : lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-neptune-stream-poller-event-bridge-role"))
  neptune_stream_poller_event_bridge_policy_name      = lower(format("%s%s%s", "${var.environment}-", local.region_short_name, "-${var.enclave_key}-neptune-stream-poller-event-bridge-policy"))

  tags                                                = local.tags
}


module "prestage_paginate_event_rule" {
  count              = var.create_pagination_infra ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-eventbridge"
  event_rule_name    = local.upload_paginate_rule
  description        = "Event rule for triggering pagination lambda (prestage buck) in kamino account"
  event_rule_pattern = {
    "source" : ["aws.s3"],
    "detail-type" : [
      "Object Created",
      "Object Deleted"
    ],
    "detail" : {
      "bucket" : {
        "name" : [ concat(module.prestage_bucket.*.bucket_id, [""])[0]]
      }
    }
  }
  event_target_id = "SendToLambda"
  target_arn      = local.paginate_lambda_arn
  event_rule_role_arn = concat(module.paginate_eventrule_roles_policies.*.role_arn, [""])[0]
  tags            = local.tags
}


module "datasync_paginate_event_rule" {
  count              = var.create_pagination_infra ? 1 : 0
  source             = "../terraform-modules/common-modules/terraform-aws-eventbridge"
  event_rule_name    = local.datasync_paginate_rule
  description        = "Event rule for triggering pagination lambda (datasync buck) in kamino account"
  event_rule_pattern = {
    "source" : ["aws.s3"],
    "detail-type" : [
      "Object Created",
      "Object Deleted"
    ],
    "detail" : {
      "bucket" : {
        "name" : [concat(module.ingest_bucket.*.bucket_id, [""])[0]]
      },
      "object" : {
        "key" : [
          {
            "wildcard" : "*/datasync/*"
          }
        ]
      }
    }
  }
  event_target_id = "SendToLambda"
  target_arn      = local.paginate_lambda_arn
  event_rule_role_arn = concat(module.paginate_eventrule_roles_policies.*.role_arn, [""])[0]
  tags            = local.tags
}
