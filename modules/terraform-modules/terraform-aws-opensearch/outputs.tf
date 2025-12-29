output "oss_collection_id" {
  description = "The ARN of collection"
  value       = aws_opensearchserverless_collection.oss_collection.id
}

output "oss_collection_arn" {
  description = "The ARN of collection"
  value       = aws_opensearchserverless_collection.oss_collection.arn
}

output "oss_collection_endpoint" {
  description = "The Endpoint of collection"
  value       = aws_opensearchserverless_collection.oss_collection.collection_endpoint
}