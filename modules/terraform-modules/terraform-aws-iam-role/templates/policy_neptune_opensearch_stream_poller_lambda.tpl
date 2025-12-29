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
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DetachNetworkInterface",
                "ec2:DeleteNetworkInterface",
                "logs:CreateLogGroup"
            ],
            "Resource": "*",
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
                "dynamodb:GetItem",
                "dynamodb:PutItem",
                "dynamodb:Scan",
                "dynamodb:UpdateItem",
                "dynamodb:DescribeTable",
                "dynamodb:DeleteItem"
            ],
            "Resource": [
                "${lease_db_table_arn}",
                "${lease_db_table_arn}/*"
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
        },
        {
            "Action": "cloudwatch:putMetricData",
            "Resource": [
                "*"
            ],
            "Effect": "Allow"
        },
        {
            "Action": [
                "neptune-db:*"
            ],
            "Resource": "${neptune_db_arn}/*",
            "Effect": "Allow"
        },
        {
            "Sid": "VisualEditor007",
            "Effect": "Allow",
            "Action": [
                "es:ESHttpHead",
                "es:ESHttpPost",
                "es:ESHttpGet",
                "es:ESHttpDelete",
                "aoss:APIAccessAll",
                "es:ESHttpPut"
            ],
            "Resource": "*"
        }
    ]
}