resource "aws_cloudwatch_dashboard" "opensearchserverless_metrics_dashboard" {
  dashboard_name = "OpenSearchServerlessMetricsDashboard"
  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x    = 0,
        y    = 0,
        width  = 12,
        height = 6,
        properties = {
          metrics = [
            ["AWS/AOSS", "SearchRequestRate", "CollectionName", "${aws_opensearchserverless_collection.oss_collection.name}", "ClientId", "${data.aws_caller_identity.current.account_id}"],
            ["AWS/AOSS", "SearchRequestLatency", "CollectionName", "${aws_opensearchserverless_collection.oss_collection.name}", "ClientId", "${data.aws_caller_identity.current.account_id}"],
            ["AWS/AOSS", "SearchOCU", "CollectionName", "${aws_opensearchserverless_collection.oss_collection.name}", "ClientId", "${data.aws_caller_identity.current.account_id}"]
          ],
          title = "OpenSearch Metrics",
          view = "timeSeries",
          stacked = false,
          region = var.region
        }
      }
    ]
  })
}

