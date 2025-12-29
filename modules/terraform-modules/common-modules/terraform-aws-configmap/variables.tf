variable "configmap_name" {
  description = "Name of the config map"
  type        = string
}

variable "configmap_namespace" {
  description = "Namespace defines the space within which name of the config map must be unique"
  type        = string
}

variable "configmap_data" {
  description = "(Map of String) Data contains the configuration data"
  type        = map(string)
}
