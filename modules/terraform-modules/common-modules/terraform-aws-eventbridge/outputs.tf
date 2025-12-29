output "event_role_arn" {
  description = "event rue arn"
  value       = concat(aws_cloudwatch_event_rule.event_rule.*.arn, [""])[0]
}