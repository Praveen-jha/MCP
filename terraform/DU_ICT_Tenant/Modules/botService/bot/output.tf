output "bot_service" {
  description = "Output of bot service resource block"
  value       = azurerm_bot_service_azure_bot.bot_service.id
}