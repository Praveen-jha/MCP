resource "azurerm_bot_service_azure_bot" "bot_service" {
  name                          = var.bot_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  microsoft_app_id              = var.microsoft_app_id
  sku                           = var.sku
  public_network_access_enabled = var.public_network_access_enabled
  local_authentication_enabled  = var.local_authentication_enabled
  endpoint                      = var.endpoint
  tags                          = var.tags
}

resource "azurerm_bot_channel_ms_teams" "teams_channel" {
  bot_name            = azurerm_bot_service_azure_bot.bot_service.name
  resource_group_name = azurerm_bot_service_azure_bot.bot_service.resource_group_name
  location            = azurerm_bot_service_azure_bot.bot_service.location
}
