output "param_arn" {
  description = "param arn"
  value       = concat(aws_ssm_parameter.create_param.*.arn, [""])[0]
}