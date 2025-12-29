resource "aws_cloudwatch_event_rule" "neptune_stream_poller_eventbridge_rule" {
  name                = join("-", [var.neptune_opensearch_stream_application_name, "PollerRule"])
  description         = "Executes the Neptune Poller Step Function Periodically"
  schedule_expression = "rate(5 minutes)"
  state               =  "ENABLED"
  tags                = var.tags   
}


resource "aws_iam_role" "eventbridge_rule_execution_role" {
  name               = var.neptune_stream_poller_event_bridge_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.eventbridge_assume_role_policy.json
}

data "aws_iam_policy_document" "eventbridge_rule_policy_permission" {
  statement {
    sid = "AllowStateInvokeAction"
    actions = [
      "states:StartExecution"
    ]
    resources = [
      "${var.neptune_stream_poller_state_machine_arn}"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "eventbridge_rule_policy" {
  name        = var.neptune_stream_poller_event_bridge_policy_name
  path        = "/"
  description = "Allow EventBridge State Machine invoke"
  policy      = data.aws_iam_policy_document.eventbridge_rule_policy_permission.json
}

resource "aws_iam_policy_attachment" "eventbridge_rule_policy_attachment" {
  name       = "eventbridge_rule_policy_attachment"
  roles      = [aws_iam_role.eventbridge_rule_execution_role.name]
  policy_arn = aws_iam_policy.eventbridge_rule_policy.arn
}

resource "aws_cloudwatch_event_target" "neptune_stream_poller_eventbridge_target" {
  arn        = var.neptune_stream_poller_state_machine_arn
  rule       = aws_cloudwatch_event_rule.neptune_stream_poller_eventbridge_rule.id
  target_id  = "neptune-poller-state-machine-target"
  role_arn = aws_iam_role.eventbridge_rule_execution_role.arn
  depends_on = [ aws_cloudwatch_event_rule.neptune_stream_poller_eventbridge_rule ]
}

data "aws_iam_policy_document" "eventbridge_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}