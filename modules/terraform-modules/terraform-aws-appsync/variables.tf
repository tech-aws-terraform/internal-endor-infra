variable "appsync_graphql_api_name" {
  description = "Name of GraphQL API"
  type        = string
  default     = ""
}

variable "authentication_type" {
  description = "The authentication type to use by GraphQL API"
  type        = string
  default     = "API_KEY"
}

variable "api_key_description" {
  description = "The API key description"
  type        = string
  default     = ""
}

variable "api_key_expires" {
  description = "RFC3339 string representation of the expiry date"
  type        = string
  default     = ""
}

variable "log_cloudwatch_logs_role_arn" {
  description = "Amazon Resource Name of the service role that AWS AppSync will assume to publish to Amazon CloudWatch logs in your account."
  type        = string
  default     = null
}

variable "log_field_log_level" {
  description = "Field logging level. Valid values: ALL, ERROR, NONE."
  type        = string
  default     = "ERROR"
}

variable "log_exclude_verbose_content" {
  description = "Set to TRUE to exclude sections that contain information such as headers, context, and evaluated mapping templates, regardless of logging level."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Map of tags to add to all GraphQL resources created by this module"
  type        = map(string)
  default     = {}
}

variable "datasource_name" {
  description = "The name of the DynamoDb datasource"
  type        = string
  default     = ""
}

variable "service_role_arn" {
  description = " The IAM service role ARN for the data source"
  type        = string
  default     = null
}

variable "datasource_type" {
  description = "The type of the DataSource. Valid values: AWS_LAMBDA, AMAZON_DYNAMODB, AMAZON_ELASTICSEARCH, HTTP, NONE"
  type        = string
  default     = "AMAZON_DYNAMODB"
}

variable "dynamodb_table_name" {
  description = "The Name of platform dynamodb table"
  type        = string
  default     = ""
}