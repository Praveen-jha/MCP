// output.tf
// This file defines the output values for the azurerm_network_interface module.

output "windows_vm_id" {
  description = "The ID of the Windows Virtual Machine."
  value       = azurerm_windows_virtual_machine.this.id
}

output "windows_vm_identity" {
  description = "The identity block of the Windows Virtual Machine."
  value = {
    principal_id = azurerm_windows_virtual_machine.this.identity[0].principal_id
    tenant_id    = azurerm_windows_virtual_machine.this.identity[0].tenant_id
    type         = azurerm_windows_virtual_machine.this.identity[0].type
  }
  sensitive = true
}

output "windows_vm_os_disk_id" {
  description = "The ID of the OS disk attached to the Windows Virtual Machine."
  value       = azurerm_windows_virtual_machine.this.os_disk[0].id
}

output "windows_vm_private_ip_address" {
  description = "The primary private IP address assigned to the Windows Virtual Machine."
  value       = azurerm_windows_virtual_machine.this.private_ip_address
}

output "windows_vm_private_ip_addresses" {
  description = "A list of private IP addresses assigned to the Windows Virtual Machine."
  value       = azurerm_windows_virtual_machine.this.private_ip_addresses
}

output "windows_vm_public_ip_address" {
  description = "The primary public IP address assigned to the Windows Virtual Machine."
  value       = azurerm_windows_virtual_machine.this.public_ip_address
}

output "windows_vm_public_ip_addresses" {
  description = "A list of public IP addresses assigned to the Windows Virtual Machine."
  value       = azurerm_windows_virtual_machine.this.public_ip_addresses
}

output "windows_vm_unique_id" {
  description = "A 128-bit unique identifier for this Windows Virtual Machine."
  value       = azurerm_windows_virtual_machine.this.virtual_machine_id
}

#Output for Network Interface Card
output "network_interface_card" {
  description = "The entire resource object for the Azure Network Interface."
  value       = azurerm_network_interface.this
}

output "network_interface_card_id" {
  description = "The ID of the Network Interface."
  value       = azurerm_network_interface.this.id
}

output "network_interface_card_name" {
  description = "The name of the Azure Network Interface."
  value       = azurerm_network_interface.this.name
}

output "network_interface_card_location" {
  description = "The Azure region where the Network Interface is deployed."
  value       = azurerm_network_interface.this.location
}

output "network_interface_card_resource_group" {
  description = "The name of the Azure Resource Group that contains the Network Interface."
  value       = azurerm_network_interface.this.resource_group_name
}

output "network_interface_card_accelerated_networking_enabled" {
  description = "Defines whether Accelerated Networking is enabled or not."
  value       = azurerm_network_interface.this.accelerated_networking_enabled
}

output "network_interface_card_applied_dns_servers" {
  description = "Union of all DNS servers from all network_interface_cards in the Availability Set."
  value       = azurerm_network_interface.this.applied_dns_servers
}

output "network_interface_card_auxiliary_mode" {
  description = "Defines the Auxilliary Mode of the network_interface_card."
  value       = azurerm_network_interface.this.auxiliary_mode
}

output "network_interface_card_auxiliary_sku" {
  description = "Defines the Auxilliary SKU of the network_interface_card."
  value       = azurerm_network_interface.this.auxiliary_sku
}

output "network_interface_card_edge_zone" {
  description = "Defines the Edge Zone of the network_interface_card."
  value       = azurerm_network_interface.this.edge_zone
}

output "network_interface_card_internal_dns_name_label" {
  description = "Defines the Internal DNS Name Label of the network_interface_card."
  value       = azurerm_network_interface.this.internal_dns_name_label
}

output "network_interface_card_internal_domain_name_suffix" {
  description = "The internal domain name suffix used to construct the DNS name for the primary network_interface_card of a VM."
  value       = azurerm_network_interface.this.internal_domain_name_suffix
}

output "network_interface_card_ip_configuration" {
  description = "Defines the IP configuration of the network_interface_card."
  value       = azurerm_network_interface.this.ip_configuration
}

output "network_interface_card_ip_forwarding_enabled" {
  description = "Defines whether IP forwarding is enabled or not."
  value       = azurerm_network_interface.this.ip_forwarding_enabled
}

output "network_interface_card_mac_address" {
  description = "The MAC (Media Access Control) address of the Network Interface."
  value       = azurerm_network_interface.this.mac_address
}

output "network_interface_card_private_ip_address" {
  description = "The first private IP address of the network_interface_card. If allocation is dynamic, Azure assigns it during creation."
  value       = azurerm_network_interface.this.private_ip_address
}

output "network_interface_card_private_ip_addresses" {
  description = "The list of private IP addresses assigned to the network_interface_card. If allocation is dynamic, Azure assigns them during creation."
  value       = azurerm_network_interface.this.private_ip_addresses
}

output "network_interface_card_virtual_machine_id" {
  description = "The ID of the Virtual Machine connected to this Network Interface."
  value       = azurerm_network_interface.this.virtual_machine_id
}