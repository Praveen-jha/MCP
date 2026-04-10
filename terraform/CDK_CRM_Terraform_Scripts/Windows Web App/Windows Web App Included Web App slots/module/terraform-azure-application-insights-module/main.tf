#Terraform code defines an Azure Application Insights resource using the azurerm_application_insights block. It provisions a monitoring service that collects telemetry data such as request rates, failures, performance metrics, and dependencies, and stores it in a connected Log Analytics workspace for analysis and diagnostics of live applications.
#Terraform Registry Link: https://registry.terraform.io/providers/hashicorp/azurerm/4.31.0/docs/resources/application_insights

resource "azurerm_application_insights" "this" {
  name                = var.application_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = var.workspace_id
  application_type    = var.application_type
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}
