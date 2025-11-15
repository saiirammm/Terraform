resource "azurerm_kubernetes_cluster" "cluster" {
  resource_group_name = var.resource_group_name
  location = var.location
  name = var.name
  default_node_pool {
    name = "node"
    auto_scaling_enabled = "true"
    max_count = 3
    min_count = 2
    vm_size    = "Standard_D2s_v4"

  }
  identity {type = "SystemAssigned"}

  dns_prefix = "true"
  workload_identity_enabled = "true"
  private_cluster_enabled = "true"
  network_profile {
    network_plugin = "azure"
    network_data_plane = "cilium"
  }
  oidc_issuer_enabled = "true"
}