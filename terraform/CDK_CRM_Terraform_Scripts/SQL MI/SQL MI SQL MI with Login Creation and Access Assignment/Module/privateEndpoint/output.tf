output "private_endpoint" {
  description = "Output: Azure private endpoint resource object"
  value       = azurerm_private_endpoint.private_endpoint
}

output "private_endpoint_ip_config" {
  value = azurerm_private_endpoint.private_endpoint.custom_dns_configs[0].ip_addresses
}
