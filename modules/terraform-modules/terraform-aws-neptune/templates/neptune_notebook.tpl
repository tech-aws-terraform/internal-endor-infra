{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3ListBucketAndGetObject",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "arn:aws:s3:::aws-neptune-notebook-${region}",
                "arn:aws:s3:::aws-neptune-notebook-${region}/*"
            ]
        },
        {
            "Sid": "DBAccess",
            "Effect": "Allow",
            "Action": "neptune-db:*",
            "Resource": [
                "arn:aws:neptune-db:${region}:${account}:${org_neptune_cluster_res_id}/*"
            ]
        },
        {
            "Sid": "LogGroupAccess",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:${region}:${account}:log-group:/aws/sagemaker/*"
            ]
        },
        {
            "Sid": "SageMakerNotebookAccess",
            "Effect": "Allow",
            "Action": "sagemaker:DescribeNotebookInstance",
            "Resource": [
                "arn:aws:sagemaker:${region}:${account}:notebook-instance/*"
            ]
        }
    ]
}