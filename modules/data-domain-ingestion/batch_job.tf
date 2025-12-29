module "batch_job" {
  count            = var.use_endor_data_domain ? 1 : 0
  source           = "../terraform-modules/common-modules/terraform-aws-batchjob"
  compute_env_count = 3
  compute_env_name = local.compute_env_name
  max_vcpus        = 256
  security_group_ids = [
    concat(module.batch_compute_env_sg.*.security_group_id, [""])[0]
  ]
  subnet_ids = [
    var.data_domain_subnet_id
  ]
  compute_inst_type      = "FARGATE"
  batch_service_role_arn = "arn:aws:iam::${var.endor_account_id}:role/aws-service-role/batch.amazonaws.com/AWSServiceRoleForBatch"
  tags = local.tags

  create_job_def        = true
  job_def_name          = local.batch_job_def_name
  job_inst_type         = "container"
  platform_capabilities = ["FARGATE"]
  container_properties = jsonencode(
    {
      "image"            = "${local.batch_job_ecr_repo_uri}:${var.batch_job_docker_img_name}-${var.batch_job_ecr_image_tag}",
      "command"          = ["echo", "test"]
      "executionRoleArn" = concat(module.ecs_task_role_policies.*.role_arn, [""])[0],
      "jobRoleArn"       = concat(module.ecs_task_role_policies.*.role_arn, [""])[0],
      "resourceRequirements" = [
        {
          "value" = "8.0",
          "type"  = "VCPU"
        },
        {
          "value" = "16384",
          "type"  = "MEMORY"
        }
      ],
      "logConfiguration" = {
        "logDriver"     = "awslogs",
        "options"       = {},
        "secretOptions" = []
      },
      "networkConfiguration" = {
        "assignPublicIp" = "DISABLED"
      },
      "fargatePlatformConfiguration" = {
        "platformVersion" = "LATEST"
      },
      "runtimePlatform" = {
        "operatingSystemFamily" = "LINUX",
        "cpuArchitecture"       = "X86_64"
      }
    }
  )

  create_job_queue = true
  job_queue_name   = local.batch_job_queue_name
  queue_state      = "ENABLED"
  priority         = 0
  depends_on = [module.ecs_task_role_policies,
    module.batch_compute_env_sg
    ]
}
