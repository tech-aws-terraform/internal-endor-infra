resource "aws_iam_service_linked_role" "batch_service_role" {
  count             =  var.create_batch_service_role ? 1 : 0
  aws_service_name  = "batch.amazonaws.com"
  description       = "Service linked role for Batch"
  lifecycle {
    ignore_changes = all
  }
}