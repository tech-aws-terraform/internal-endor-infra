output "sqs_queue_id" {
  description = "SQS Queue Id"
  value       = concat(aws_sqs_queue.sqs_queue.*.id, [""])[0]
}

output "sqs_queue_arn" {
  description = "SQS Queue ARN"
  value       = concat(aws_sqs_queue.sqs_queue.*.arn, [""])[0]
}