resource "kubernetes_config_map_v1" "configmap" {

  metadata {
    name      = var.configmap_name
    namespace = var.configmap_namespace
  }

  data        = var.configmap_data

  lifecycle {
    # We are ignoring the data here since we will manage it with the resource below
    # This is only intended to be used in scenarios where the configmap does not exist
    ignore_changes = [metadata[0].labels, metadata[0].annotations]
  }
}