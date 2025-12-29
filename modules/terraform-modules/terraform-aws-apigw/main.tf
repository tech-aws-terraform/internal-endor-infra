resource "aws_api_gateway_account" "api_gw_account" {
  cloudwatch_role_arn = var.apigw_cw_role_arn
}

resource "aws_api_gateway_rest_api" "api_gw_rest_api" {
  body  = templatefile("${path.module}/templates/apigw_spec.tpl", {
            region          = var.region,
            auth_lambda_arn = var.auth_lambda_arn,
            version         = timestamp()
         })

  name  = var.apigw_rest_api_name

  endpoint_configuration {
    types = var.endpoint_types
  }

  disable_execute_api_endpoint = false
  description = "API for Securing Transfer Family"

  depends_on = [ aws_api_gateway_account.api_gw_account ]
}

resource "aws_api_gateway_deployment" "api_gw_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gw_rest_api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_gw_rest_api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_gateway_stage" {
  deployment_id = aws_api_gateway_deployment.api_gw_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gw_rest_api.id
  stage_name    = var.api_gw_stage_name
}

resource "aws_api_gateway_method_settings" "api_gateway_settings" {
  rest_api_id = aws_api_gateway_rest_api.api_gw_rest_api.id
  stage_name  = aws_api_gateway_stage.api_gateway_stage.stage_name
  method_path = "*/*"

  settings {
    metrics_enabled        = true
    throttling_burst_limit = var.throttle_burst_lt
    throttling_rate_limit  = var.throttle_rate_lt
    logging_level          = var.logging_level
    data_trace_enabled     = true
  }
}

# Providing policy for Auth Lambda for APi Gateway
resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateWay"
  action        = "lambda:InvokeFunction"
  function_name = var.auth_lambda_func
  principal     = "apigateway.amazonaws.com"
  source_arn    = format("%s%s", aws_api_gateway_rest_api.api_gw_rest_api.execution_arn, var.api_resource_path)
}

