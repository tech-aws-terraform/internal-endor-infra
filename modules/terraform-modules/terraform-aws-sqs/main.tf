resource "aws_sqs_queue" "sqs_queue" {
  name  = var.sqs_queue_name
  tags  = var.tags
}

resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  queue_url = aws_sqs_queue.sqs_queue.id

   policy = jsonencode(
    {
        "Version": "2012-10-17",
        "Id": "__default_policy_ID",
        "Statement": [
            {
            "Sid": "__owner_statement",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${var.endor_account_id}:root"
            },
            "Action": "SQS:*",
            "Resource": "${aws_sqs_queue.sqs_queue.arn}"
            },
            {
            "Sid": "Enclave_Allow_Policy",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${var.enclave_trust_iam_roles}"
            },
            "Action": "SQS:*",
            "Resource": "${aws_sqs_queue.sqs_queue.arn}"
            }
        ]
    })
}