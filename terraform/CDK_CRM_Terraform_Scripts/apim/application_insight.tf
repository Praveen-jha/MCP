# Create a new Application Insights instance if one isn't provided
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights
# Create a new Application Insights instance if one isn't provided
resource "azurerm_application_insights" "new" {
  count               = var.app_insight_enabled && var.application_insights_name == "" ? 1 : 0
  name                ="application-insight-$(var.prefix)-${var.name}" 
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type
  workspace_id        = var.log_analytics_workspace_name != "" ? data.azurerm_log_analytics_workspace.existing[0].id : azurerm_log_analytics_workspace.new[0].id
  tags                = var.tags
}
