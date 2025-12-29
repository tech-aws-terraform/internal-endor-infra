
resource "aws_glue_job" "etl_jobs" {
  name     = var.glue_job_name
  role_arn = var.role_arn
  connections  = var.connections
  command {
    name            = var.command_name
    python_version  = var.python_version
    script_location = var.script_location
  }
  default_arguments = var.env_vars
  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }
  glue_version      = var.glue_version
  max_retries       = var.max_retries
  worker_type       = var.worker_type
  number_of_workers = var.no_of_workers
  timeout           = var.timeout
  tags              = var.tags
}