resource "aws_batch_compute_environment" "compute_env" {
  count = var.compute_env_count
  compute_environment_name = "${var.compute_env_name}-${count.index + 1}"
  compute_resources {
    max_vcpus = var.max_vcpus
    security_group_ids = var.security_group_ids
    subnets = var.subnet_ids
    type = var.compute_inst_type
  }
  service_role = var.batch_service_role_arn
  type         = "MANAGED"
  tags = var.tags
}

resource "aws_batch_job_definition" "job_definition"{
  count = var.create_job_def ? 1 : 0
  name = var.job_def_name
  type = var.job_inst_type
  platform_capabilities = var.platform_capabilities
  container_properties = var.container_properties
}


resource "aws_batch_job_queue" "endor_job_queue" {
  count = var.create_job_queue ? 1 : 0
  name     = var.job_queue_name
  state    = var.queue_state
  priority = var.priority

  compute_environment_order {
    order               = 1
    compute_environment = aws_batch_compute_environment.compute_env[0].arn
  }
    compute_environment_order {
    order               = 2
    compute_environment = aws_batch_compute_environment.compute_env[1].arn
  }
    compute_environment_order {
    order               = 3
    compute_environment = aws_batch_compute_environment.compute_env[2].arn
  }
}