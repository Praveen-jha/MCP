resource "azurerm_data_factory" "data_factory" {
  name                            = var.data_factory_name
  location                        = var.data_factory_location
  resource_group_name             = var.data_factory_rg
  public_network_enabled          = var.public_network_enabled
  managed_virtual_network_enabled = var.managed_virtual_network_enabled
  tags                            = var.tags
  dynamic "github_configuration" {
    for_each = var.github_configuration
    content {
      account_name       = each.value.account_name
      branch_name        = each.value.branch_name
      git_url            = lookup(var.github_configuration, "git_url", null)
      repository_name    = each.value.repository_name
      root_folder        = each.value.root_folder
      publishing_enabled = lookup(var.github_configuration, "publishing_enabled", null)
    }
  }
  identity {
    type = var.identity_type
    # identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : null
  }
  lifecycle {
    ignore_changes = [
      identity,
      tags,
      vsts_configuration,
      public_network_enabled
    ]
    prevent_destroy = true
  }
}
