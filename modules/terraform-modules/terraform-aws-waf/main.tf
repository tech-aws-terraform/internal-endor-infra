resource "aws_wafv2_web_acl" "waf" {
  name        = var.transfer_secured_waf_name
  description = "WAF managed rules for API Gateway and securing Transfer Family"
  scope       = var.scope

  default_action {
    block {}
  }

  rule {
    name     = "AllowStarcapRegexPatternMatchSet"
    priority = 0

    action {
      allow {}
    }

    statement {
      regex_match_statement {
        regex_string = var.regex_pattern_str
        field_to_match {
          uri_path {}
        }
        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AllowStarcapRegexPatternMatchSet"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.transfer_secured_metric_name
    sampled_requests_enabled   = true
  }

  tags        = var.tags
}

resource "aws_wafv2_web_acl_association" "waf_association" {
  resource_arn = var.transfer_secure_api_stage_arn
  web_acl_arn  = aws_wafv2_web_acl.waf.arn
}

resource "aws_cloudwatch_log_group" "waf_log_group" {
  name  = "aws-waf-logs-${var.transfer_secured_waf_name}"
  tags  = var.tags
}

resource "aws_wafv2_web_acl_logging_configuration" "waf_logging_config" {
  log_destination_configs = [aws_cloudwatch_log_group.waf_log_group.arn]
  resource_arn            = aws_wafv2_web_acl.waf.arn
}