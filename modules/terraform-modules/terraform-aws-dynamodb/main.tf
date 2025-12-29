locals {
  dynamodb_tbl_name        = var.dynamodb_tbl_name
}

########## PTFM DynamoDB Table ##########
resource "aws_dynamodb_table" "ptfm_dynamodb_table" {
  count          = var.create_metadata_table ? 1 : 0
  name           = local.dynamodb_tbl_name
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "dataset_id"
  range_key      = "dataset_name"

  attribute {
    name = "dataset_id"
    type = "S"
  }

  attribute {
    name = "dataset_name"
    type = "S"
  }

  attribute {
    name = "project_id"
    type = "S"
  }

  point_in_time_recovery {
    enabled = var.point_in_time_recovery_enabled
  }

  global_secondary_index {
    name               = "ProjectId-Index"
    hash_key           = "project_id"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "ALL"
  }
}

resource "aws_dynamodb_table" "lease_dynamodb_table" {
count          = var.create_neptune_poller_table ? 1 : 0
  name         = join("-", [var.neptune_opensearch_stream_application_name, "LeaseTable"])
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "leaseKey"

  attribute {
    name = "leaseKey"
    type = "S"
  }

  point_in_time_recovery {
    enabled = true
  }

  tags = var.tags
}