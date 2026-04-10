# Provisions an Azure Private Endpoint for secure, private connectivity to Azure services over a private link, associating it with a virtual network to eliminate public internet exposure and optionally integrate with private DNS zones.
#Description: Provisions an Azure Private Endpoint to securely connect to an Azure Service Bus Namespace over a private link.
#Terraform register link: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
 
resource "azurerm_private_endpoint" "this" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tags
 
  # Optional: Custom name for the network interface
  custom_network_interface_name = try(var.custom_network_interface_name, null)
  private_service_connection {
    name                              = var.private_service_connection_name
    is_manual_connection              = var.is_manual_connection
    private_connection_resource_id    = try(var.private_connection_resource_id, null)
    subresource_names                 = try(var.subresource_names, null)
    request_message                   = var.is_manual_connection ? try(var.request_message, null) : null
  }
 
  dynamic "ip_configuration" {
    for_each = var.ip_configuration == null ? [] : var.ip_configuration
    content {
      name               = var.ip_configuration.name
      private_ip_address = var.ip_configuration.private_ip_address
      subresource_name   = try(var.ip_configuration.subresource_name, null)
      member_name        = try(var.ip_configuration.member_name, null)
    }
  }
 
  dynamic "private_dns_zone_group" {
    for_each = var.enable_private_dns_zone_group ? ["private_dns_zone_group"] : []
    content {
      name                 = var.private_dns_zone_group_name
      private_dns_zone_ids = var.private_dns_zone_ids
    }
  }
}
