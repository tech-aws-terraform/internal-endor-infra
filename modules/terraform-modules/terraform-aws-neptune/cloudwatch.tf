resource "aws_cloudwatch_dashboard" "neptune" {
  dashboard_name = "${var.enclave_key}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/Neptune",
              "ServerlessDatabaseCapacity"
            ],
            [
              "AWS/Neptune",
              "NCUUtilization"
            ],
            [
              "AWS/Neptune",
              "VolumeBytesUsed"
            ]
          ]
          period = 300
          stat   = "Average"
          region = var.region
          title  = "${var.enclave_key} Metrics"
        }
      }
    ]
  })
}
