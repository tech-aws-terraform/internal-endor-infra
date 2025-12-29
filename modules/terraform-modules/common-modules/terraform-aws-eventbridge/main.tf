resource "aws_cloudwatch_event_rule" "event_rule" {
  name          = var.event_rule_name
  description   = var.description
  event_pattern = jsonencode(var.event_rule_pattern)
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = var.event_target_id
  arn       = var.target_arn
  role_arn = var.event_rule_role_arn
  depends_on = [ aws_cloudwatch_event_rule.event_rule]
}

