output "vpnGatewayName" {
  description = "The name of the Azure VPN Gateway"
  value       = azurerm_virtual_network_gateway.virtualNetworkGateway.name
}
output "vpnGatewayId" {
  description = "The ID of the Azure VPN Gateway"
  value       = azurerm_virtual_network_gateway.virtualNetworkGateway.id
}