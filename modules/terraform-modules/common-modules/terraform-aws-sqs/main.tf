resource "aws_sqs_queue" "sqs_queue" {
  name  = var.sqs_queue_name
  visibility_timeout_seconds = var.sqs_visibility_timeout
  tags  = var.tags
}

resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  queue_url = aws_sqs_queue.sqs_queue.id
  policy = var.policy
}

