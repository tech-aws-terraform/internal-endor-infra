output "lambda_arn" {
  description = "Lambda ARN"
  value       = concat(aws_lambda_function.lambda_function.*.arn, [""])[0]
}