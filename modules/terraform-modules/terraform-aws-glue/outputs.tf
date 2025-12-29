output "glue_etl_job_arn" {
  description = "Glue ETL Job ARN"
  value       = aws_glue_job.glue_job.arn
}

output "glue_etl_job_id" {
  description = "Glue ETL Job ID"
  value       = aws_glue_job.glue_job.id
}