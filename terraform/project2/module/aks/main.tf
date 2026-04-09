resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                                = var.aks_name
  location                            = var.location
  resource_group_name                 = var.rg_name
  sku_tier                            = var.sku_tier
  private_cluster_enabled             = var.private_cluster_enabled
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled
  dns_prefix                          = var.dns_prefix
  node_resource_group                 = var.node_resource_group
  local_account_disabled              = var.local_account_disabled
  disk_encryption_set_id              = var.disk_encryption_set_id
  kubernetes_version                  = var.kubernetes_version

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = var.azure_rbac_enabled
    tenant_id          = var.tenant_id
  }

  dynamic "oms_agent" {
    for_each = var.osm_agent_enabled == true ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  automatic_upgrade_channel = var.automatic_upgrade_channel

  network_profile {
    network_plugin = var.network_plugin
    network_policy = var.network_policy
    outbound_type  = var.outbound_type
  }

  default_node_pool {
    name                        = var.node_pool_name
    vnet_subnet_id              = var.vnet_subnet_id
    vm_size                     = var.vm_size
    os_sku                      = var.os_sku
    os_disk_type                = var.os_disk_type
    os_disk_size_gb             = var.os_disk_size_gb
    zones                       = var.node_pool_zones
    temporary_name_for_rotation = var.sys_temporary_name_for_rotation
    node_count                  = var.node_count
    auto_scaling_enabled        = var.enable_auto_scaling
    max_count                   = var.system_max_count
    min_count                   = var.system_min_count
    max_pods                    = var.system_max_pods
    host_encryption_enabled     = var.host_encryption_enabled

    node_labels = {
      "mode" = "system"
    }
    only_critical_addons_enabled = var.only_critical_addons_enabled
  }

  identity {
    type = var.identity_type
  }

  api_server_access_profile {
    authorized_ip_ranges = var.authorized_ip_ranges
  }

  azure_policy_enabled = var.azure_policy_enabled

  key_vault_secrets_provider {
    secret_rotation_enabled = var.secret_rotation_enabled
  }

  tags = var.aks_tags
  lifecycle {
    ignore_changes = [
      default_node_pool, key_vault_secrets_provider
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "node_cc" {
  for_each                    = var.node_pool
  name                        = each.value.name
  kubernetes_cluster_id       = azurerm_kubernetes_cluster.kubernetes_cluster.id
  vnet_subnet_id              = var.vnet_subnet_id
  mode                        = each.value.mode
  vm_size                     = each.value.vm_size
  os_type                     = each.value.os_type
  os_sku                      = each.value.os_sku
  os_disk_type                = each.value.os_disk_type
  os_disk_size_gb             = each.value.os_disk_size_gb
  auto_scaling_enabled        = each.value.enable_auto_scaling
  node_count                  = each.value.node_count
  max_count                   = each.value.max_count
  min_count                   = each.value.min_count
  zones                       = each.value.zones
  temporary_name_for_rotation = each.value.usr_temporary_name_for_rotation
  max_pods                    = each.value.max_pods
  node_labels                 = each.value.node_labels
  host_encryption_enabled     = each.value.host_encryption_enabled
  depends_on                  = [azurerm_kubernetes_cluster.kubernetes_cluster]
  lifecycle {
    ignore_changes = [
      max_count, min_count
    ]
  }
}
