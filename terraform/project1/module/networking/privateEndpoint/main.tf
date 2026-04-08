# Creates a private endpoint in Azure, associating it with a specified subnet within a resource group and location.
resource "azurerm_private_endpoint" "private_endpoint" {
  name                          = var.private_endpoint_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_endpoint_id
  custom_network_interface_name = var.custom_network_interface_name
  tags                          = var.tags
  # Specifies the configuration for a private service connection, including its name, resource ID, subresource names, and whether it's a manual connection.
  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.private_connection_subresource_names
    is_manual_connection           = var.is_manual_connection
  }
  # Configures a group of private DNS zones, including the group name and associated zone IDs, if provided.
  dynamic "private_dns_zone_group" {
    for_each = var.private_dns_zone_group_name == "" ? [] : [1]
    content {
      name                 = var.private_dns_zone_group_name == "" ? null : var.private_dns_zone_group_name
      private_dns_zone_ids = var.private_dns_zone_group_name == [""] ? null : var.private_dns_zone_ids
    }
  }
  lifecycle {
    ignore_changes = [
      # private_dns_zone_group,
      # private_service_connection,
      # tags
    ]
  }
}

