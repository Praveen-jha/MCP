resource "azurerm_windows_function_app" "function_app_windows" {
  name                          = var.fa_name
  resource_group_name           = var.rg_name
  location                      = var.location
  storage_account_name          = var.storage_account_name
  storage_account_access_key    = var.storage_account_access_key
  service_plan_id               = var.asp_id
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = var.tags
  virtual_network_subnet_id     = var.virtual_network_subnet_id

  # app_settings = {
  #   "FUNCTIONS_WORKER_RUNTIME" = var.functions_worker_runtime
  # }

  site_config {
    always_on                = var.always_on
    vnet_route_all_enabled   = var.vnet_route_all_enabled
    use_32_bit_worker        = var.use_32_bit_worker
    elastic_instance_minimum = var.elastic_instance_minimum

    dynamic "application_stack" {
      for_each = var.dotnet_stack == {} ? [] : [null]
      content {
        dotnet_version = var.dotnet_stack.dotnet_version
      }
    }
  }

  identity {
    type = var.identity_type
  }

  lifecycle {
    ignore_changes = []
  }
}
