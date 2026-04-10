output "id" {
  value       = azurerm_public_ip.this.id
  description = "The ID of this Public IP."
}

output "ip_address" {
  value       = azurerm_public_ip.this.ip_address
  description = "The IP address value that was allocated."
}

output "fqdn" {
  value       = azurerm_public_ip.this.fqdn
  description = "Fully qualified domain name of the A DNS record associated with the public IP."
}

output "public_ip" {
  value       = azurerm_public_ip.this
  description = "Full resource output of the Public IP."
}
