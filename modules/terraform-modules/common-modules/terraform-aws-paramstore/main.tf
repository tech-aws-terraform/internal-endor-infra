resource "aws_ssm_parameter" "create_param" {
  name  = var.param_name
  type  = var.param_type
  value = var.param_value
}