output "event_pipe_arn" {
  description = "event pipe arn"
  value       = concat(aws_pipes_pipe.eventbridge-pipe.*.arn, [""])[0]
}

output "event_pipe_id" {
  description = "event pipe id"
  value       = concat(aws_pipes_pipe.eventbridge-pipe.*.id, [""])[0]
}