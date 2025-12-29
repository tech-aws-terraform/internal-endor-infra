{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "execute-api:Invoke",
                "execute-api:ManageConnections"
            ],
            "Resource": "arn:aws:execute-api:${region}:${endor_account_id}:${apigw_id}/*"
        },
        {
            "Action": [
                "apigateway:*"
            ],
            "Resource": "arn:aws:apigateway:${region}::/restapis/${apigw_id}/*",
            "Effect": "Allow"
        }
    ]
}