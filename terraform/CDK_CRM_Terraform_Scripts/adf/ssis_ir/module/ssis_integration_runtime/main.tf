# Terraform configuration for Azure Data Factory SSIS Integration Runtime
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory_integration_runtime_azure_ssis#credential_name-1
resource "azurerm_data_factory_integration_runtime_azure_ssis" "this" {
  name            = var.name
  data_factory_id = var.data_factory_id
  location        = var.location
  node_size       = var.node_size

  # Optional parameters
  description                      = var.description
  edition                          = var.edition
  license_type                     = var.license_type
  max_parallel_executions_per_node = var.max_parallel_executions_per_node
  number_of_nodes                  = var.number_of_nodes
  credential_name                  = var.credential_name

  # Dynamic blocks for complex optional parameters
  dynamic "catalog_info" {
    for_each = var.catalog_info != null ? [var.catalog_info] : []
    content {
      server_endpoint        = catalog_info.value.server_endpoint
      administrator_login    = try(catalog_info.value.administrator_login, null)
      administrator_password = try(catalog_info.value.administrator_password, null)
      pricing_tier           = try(catalog_info.value.pricing_tier, null)
      dual_standby_pair_name = try(catalog_info.value.dual_standby_pair_name, null)
      elastic_pool_name      = try(catalog_info.value.elastic_pool_name, null)
    }
  }

  dynamic "vnet_integration" {
    for_each = var.vnet_integration != null ? [var.vnet_integration] : []
    content {
      vnet_id     = try(vnet_integration.value.vnet_id, null)
      subnet_name = try(vnet_integration.value.subnet_name, null)
      subnet_id   = try(vnet_integration.value.subnet_id, null)
      public_ips  = try(vnet_integration.value.public_ips, null)
    }
  }
}
