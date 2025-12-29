resource "aws_sfn_state_machine" "state_machine" {
  name       = var.state_machine_name
  role_arn   = var.state_machine_role_arn
  definition = var.state_machine_definition  
  }