output "neptune_stream_poller_state_machine_arn" {
  description = "Neptune Stream Poller State Machine ARN"
  value = aws_sfn_state_machine.neptune_stream_poller_state_machine.arn
}

output "neptune_stream_poller_state_machine_name" {
  description = "Neptune Stream Poller State Machine Name"
  value = aws_sfn_state_machine.neptune_stream_poller_state_machine.name
}