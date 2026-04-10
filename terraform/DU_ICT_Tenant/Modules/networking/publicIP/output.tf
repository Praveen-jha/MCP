output "public_ip_id" {
  value = azurerm_public_ip.vpn_gw_pip.id
  description = "ID of public IP address"
}