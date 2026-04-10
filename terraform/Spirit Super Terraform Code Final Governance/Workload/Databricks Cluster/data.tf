data "azurerm_databricks_workspace" "databricks" {
  name                = "db-poc-databricks"
  resource_group_name = "db-poc-rg"
}
