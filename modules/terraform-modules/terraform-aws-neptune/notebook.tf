/*
resource "aws_sagemaker_notebook_instance_lifecycle_configuration" "this" {
  name      = "${var.enclave_key}-neptune-notebook-lc"
  on_start  = base64encode(templatefile("${path.module}/templates/on_start_mount.tpl", {
    neptune_url              = aws_neptune_cluster.this.endpoint
    neptune_port             = 8182
    role_arn                 = aws_iam_role.notebook.arn
    aws_region               = var.region
  }))
}

resource "aws_sagemaker_notebook_instance" "this" {
  name                   = var.neptune_notebook_name
  role_arn               = aws_iam_role.notebook.arn
  instance_type          = "ml.t3.medium"
  direct_internet_access = "Enabled"
  root_access            = "Disabled"
  lifecycle_config_name  = aws_sagemaker_notebook_instance_lifecycle_configuration.this.name
  volume_size            = 5
  security_groups = [
    aws_security_group.this.id
  ]
  subnet_id = var.subnet_ids[0]
  tags = merge({ "Name" = "${var.enclave_key}-notebook", "aws-neptune-cluster-id" = aws_neptune_cluster.this.id, "aws-neptune-resource-id" = aws_neptune_cluster.this.cluster_resource_id }, var.tags)
}*/
