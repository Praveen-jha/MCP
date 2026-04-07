 # Resource block Azure Databricks Workspace
resource "azurerm_databricks_workspace" "databricks_workspace" {
  name                         = var.databricks_workspace_name
  resource_group_name          = var.databricks_workspace_rg
  location                     = var.databricks_workspace_location
  sku                          = var.databricks_workspace_sku
  tags                         = var.tags
  managed_resource_group_name  = var.databricks_managed_rg
  public_network_access_enabled         = var.public_network_enabled
  network_security_group_rules_required = var.databricks_nsg_rules_required
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled

  # This block configures custom parameters for a Databricks deployment, including network settings and storage account information.
  custom_parameters {
    no_public_ip                                         = var.databricks_custom_parameters.no_public_ip
    virtual_network_id                                   = var.databricks_custom_parameters.virtual_network_id
    private_subnet_name                                  = var.databricks_custom_parameters.private_subnet_name
    private_subnet_network_security_group_association_id = var.databricks_custom_parameters.private_subnet_network_security_group_association_id
    public_subnet_name                                   = var.databricks_custom_parameters.public_subnet_name
    public_subnet_network_security_group_association_id  = var.databricks_custom_parameters.public_subnet_network_security_group_association_id
    # storage_account_name                                 = var.databricks_custom_parameters.storage_account_name
  }

 
  lifecycle {
    ignore_changes = [
      # custom_parameters,         
      # tags                         
    ]
  }
}
