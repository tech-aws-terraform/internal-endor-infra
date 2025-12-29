output "transfer_secure_api_id" {
  description = "Transfer Secure API Gateway ID"
  value       = concat(aws_api_gateway_rest_api.api_gw_rest_api.*.id, [""])[0]
}

output "transfer_secure_api_arn" {
  description = "Transfer Secure API Gateway ARN"
  value       = concat(aws_api_gateway_rest_api.api_gw_rest_api.*.arn, [""])[0]
}

output "transfer_secure_api_execution_arn" {
  description = "Transfer Secure API Gateway execution arn"
  value       = concat(aws_api_gateway_rest_api.api_gw_rest_api.*.execution_arn, [""])[0]
}

output "transfer_secure_api_stage_id" {
  description = "Starcap Transfer Secure API Gateway Stage ID"
  value       = concat(aws_api_gateway_stage.api_gateway_stage.*.id, [""])[0]
}

output "transfer_secure_api_stage_arn" {
  description = "Transfer Secure API Gateway stage ARN"
  value       = concat(aws_api_gateway_stage.api_gateway_stage.*.arn, [""])[0]
}

output "transfer_secure_api_stage_invoke_url" {
  description = "Transfer Secure API Gateway stage Invoke URL"
  value       = concat(aws_api_gateway_stage.api_gateway_stage.*.invoke_url, [""])[0]
}