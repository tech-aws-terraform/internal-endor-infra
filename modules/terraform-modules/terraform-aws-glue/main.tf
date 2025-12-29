resource "aws_glue_job" "glue_job" {
  name         = var.glue_job_name
  role_arn     = var.role_arn
  max_capacity = var.max_capacity

  connections  = []

  command {
    name            = var.command_name
    script_location = var.script_location
    python_version  = var.python_version
  }

  default_arguments = {
    "--SQS_URL"                          = var.sqs_url
    "--VPC_URL"                          = var.vpc_url
  }

  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }

  tags = var.tags
}

