{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "lambda:InvokeFunction",
            "Resource": "arn:aws:lambda:*:*:function:*",
            "Effect": "Allow"
        },
        {
            "Action": [
                "xray:PutTraceSegments",
                "xray:PutTelemetryRecords",
                "logs:CreateLogGroup"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:*:log-group:*",
                "arn:aws:logs:*:*:log-group:*:log-stream:*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "dynamodb:UpdateItem"
            ],
            "Resource": [
                "arn:aws:dynamodb:*:*:table/*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "states:ListExecutions",
                "states:StartExecution",
                "states:DescribeExecution"
            ],
            "Resource": [
                "arn:aws:states:*:*:execution:*:*",
                "arn:aws:states:*:*:stateMachine:*"
            ],
            "Effect": "Allow"
        }
    ]
}