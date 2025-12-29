data "aws_region" "current" {}
data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

######################
# Neptune cluster
######################

resource "aws_neptune_cluster" "this" {
  allow_major_version_upgrade          = var.allow_major_version_upgrade
  apply_immediately                    = var.apply_immediately
  backup_retention_period              = var.backup_retention_period
  cluster_identifier                   = var.cluster_identifier
  deletion_protection                  = var.deletion_protection
  enable_cloudwatch_logs_exports       = try(var.enable_cloudwatch_logs_exports, null)
  engine                               = var.engine
  engine_version                       = data.aws_neptune_engine_version.neptune.version != null ? data.aws_neptune_engine_version.neptune.version : var.engine_version
  iam_database_authentication_enabled  = var.iam_database_authentication_enabled
  iam_roles                            = [aws_iam_role.neptune.arn]
  kms_key_arn                          = try(var.kms_key_arn, null)
  neptune_cluster_parameter_group_name = try(aws_neptune_cluster_parameter_group.this.name, null)
  neptune_subnet_group_name            = try(aws_neptune_subnet_group.this.name, null)
  preferred_backup_window              = var.preferred_backup_window
  skip_final_snapshot                  = var.skip_final_snapshot
  storage_encrypted                    = var.storage_encrypted
  vpc_security_group_ids               = try([aws_security_group.this.id], var.vpc_security_group_ids)

  dynamic "serverless_v2_scaling_configuration" {
    for_each = var.enable_serverless ? [1] : []
    content {
      min_capacity = var.min_capacity
      max_capacity = var.max_capacity
    }
  }

  tags = var.tags
}

resource "aws_neptune_cluster_instance" "this" {
  count                        = var.create_neptune_instance ? var.instance_count : 0
  cluster_identifier           = aws_neptune_cluster.this.cluster_identifier
  identifier                   = "${var.cluster_identifier}-instance-${count.index}"
  instance_class               = "db.serverless"
  neptune_parameter_group_name = aws_neptune_parameter_group.this.name
  neptune_subnet_group_name    = aws_neptune_subnet_group.this.name
  promotion_tier               = var.promotion_tier

  tags = merge(var.tags, var.neptune_cluster_instance_tags)
}

######################
# Parameter groups
######################
resource "aws_neptune_cluster_parameter_group" "this" {
  name        = "${var.cluster_identifier}-db-parameter-group"
  description = "Neptune Cluster DB Parameter Group"
  family      = var.neptune_family

  parameter {
    name  = "neptune_autoscaling_config"
    value = ""
  }

  parameter {
    name  = "neptune_enable_audit_log"
    value = "0"
  }

  parameter {
    name  = "neptune_enable_slow_query_log"
    value = "disabled"
  }

  parameter {
    name  = "neptune_lab_mode"
    value = "Streams=enabled, ReadWriteConflictDetection=enabled"
  }

  parameter {
    name  = "neptune_lookup_cache"
    value = "1"
  }

  parameter {
    name  = "neptune_ml_endpoint"
    value = ""
  }

  parameter {
    name  = "neptune_ml_iam_role"
    value = ""
  }

  parameter {
    name  = "neptune_streams"
    value = "1"
  }

  parameter {
    name  = "neptune_streams_expiry_days"
    value = "7"
  }

  tags = merge(var.tags, var.neptune_cluster_parameter_group_tags)
}

resource "aws_neptune_parameter_group" "this" {
  name        = "${var.cluster_identifier}-instance-parameter-group"
  description = "Neptune DB Cluster Instance Parameter Group"
  family      = var.neptune_family

  parameter {
    name  = "neptune_dfe_query_engine"
    value = "viaQueryHint"
  }

  parameter {
    name  = "neptune_query_timeout"
    value = "120000"
  }

  parameter {
    name  = "neptune_result_cache"
    value = "1"
  }

  tags = merge(var.tags, var.neptune_parameter_group_tags)
}

######################
# Subnet groups
######################
resource "aws_neptune_subnet_group" "this" {
  name        = "${var.cluster_identifier}-subnet-group"
  description = "Neptune Subnet Group"
  subnet_ids  = var.subnet_ids

  tags = merge(var.tags, var.neptune_subnet_group_tags)
}
