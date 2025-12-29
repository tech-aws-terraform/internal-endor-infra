output "neptune_cluster_arn" {
  description = "Neptune Cluster ARN"
  value = aws_neptune_cluster.this.arn
}

output "neptune_cluster_id" {
  description = "Neptune Cluster ID/Name"
  value = aws_neptune_cluster.this.id
}

output "neptune_cluster_resource_id" {
  description = "Neptune Cluster Resource ID"
  value = aws_neptune_cluster.this.cluster_resource_id
}

output "neptune_cluster_sg_id" {
  description = "Neptune Cluster Security Group"
  value = aws_security_group.this.id
}

#output "neptune_writer_endpoint" {
#  description = "Neptune Cluster Writer Endpoint"
#  value = replace(aws_neptune_cluster_instance.this[1].endpoint, ":8182", "")
#}
output "neptune_writer_endpoint" {
  description = "The endpoint of the Neptune cluster writer instance"
  value = try(
    [for instance in aws_neptune_cluster_instance.this : instance.address if instance.writer][0],
    null
  )
}

output "neptune_reader_endpoint" {
  description = "Neptune Cluster Reader Endpoint"
  value = aws_neptune_cluster.this.reader_endpoint
}

output "neptune_port" {
  description = "Neptune Port"
  value = aws_neptune_cluster.this.port
}

output "neptune_iam_auth_role_id" {
  description = "Neptune IAM Authentication Role ID"
  value = aws_iam_role.neptune.id
}

output "neptune_iam_auth_role_arn" {
  description = "Neptune IAM Authentication Role ARN"
  value = aws_iam_role.neptune.arn
}

#output "neptune_notebook_graph_explorer" {
#  description = "Neptune Notebook Graph Explorer"
#  value = format("%s%s%s", "https://", aws_sagemaker_notebook_instance.this.id, ".notebook.${var.region}.sagemaker.aws/proxy/9250/explorer/")
#}