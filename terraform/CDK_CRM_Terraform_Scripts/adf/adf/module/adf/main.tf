#Provisions an Azure Data Factory instance with optional GitHub integration for source control, managed identity support, and secure network configurations including managed virtual network and public network access control, enabling scalable and secure data orchestration across services.
#Terraform register link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory

resource "azurerm_data_factory" "this" {
  name                             = var.data_factory_name
  location                         = var.data_factory_location
  resource_group_name              = var.data_factory_rg
  public_network_enabled           = var.public_network_enabled
  managed_virtual_network_enabled  = var.managed_virtual_network_enabled
  customer_managed_key_id          = var.customer_managed_key_id
  customer_managed_key_identity_id = var.customer_managed_key_identity_id
  tags                             = var.tags

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
    type         = var.identity_type
    identity_ids = var.identity_type == "SystemAssigned" ? null : var.identity_ids
  }
}
