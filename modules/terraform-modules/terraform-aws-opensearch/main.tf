#Creates a collection
resource "aws_opensearchserverless_collection" "oss_collection" {
  name              = var.oss_collection_name
  #standby_replicas  = var.oss_collection_standby_replicas
  type              = var.oss_collection_type
  tags              = var.tags

  depends_on = [aws_opensearchserverless_security_policy.oss_security_encryption_policy]
}