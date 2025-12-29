output "compute_env_arn" {
  description = "compute env arn"
  value       = concat(aws_batch_compute_environment.compute_env.*.arn, [""])[0]
}

output "job_definition_arn" {
  description = "job definition arn"
  value = concat(aws_batch_job_definition.job_definition.*.arn, [""])[0]
}

output "job_queue_name" {
  description = "job queue name"
  value = concat(aws_batch_job_queue.endor_job_queue.*.name, [""])[0]
}