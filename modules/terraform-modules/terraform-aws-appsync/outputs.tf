output "appsync_api_id" {
  description = "Appsync API id"
  value       = aws_appsync_graphql_api.appsync_graphql_api.id
}

output "appsync_api_uris" {
  description = "Appsync API uris"
  value       = aws_appsync_graphql_api.appsync_graphql_api.uris
}

output "appsync_arn" {
  description = "Appsync ARN"
  value       = aws_appsync_graphql_api.appsync_graphql_api.arn
}

# DEV_1268599_appsync-api-key-inclusion-changes
output "api_key" {
  description = "API Key"
  value       = aws_appsync_api_key.appsync_api_key.key
}

# DEV_1268599_appsync-api-key-inclusion-changes
output "api_key_id" {
  description = "API Key ID"
  value       = aws_appsync_api_key.appsync_api_key.id
}