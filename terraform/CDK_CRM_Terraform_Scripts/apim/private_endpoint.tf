# --- Private Endpoint and DNS ---
#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_private_endpoint" "app_endpoint" {
  count               = var.enable_private_endpoint  ? 1 : 0
  name                = "pe-$(var.prefix)-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = try(data.azurerm_subnet.pe[0].id, null)

  private_service_connection {
    name                           = "psc-$(var.prefix)-${var.name}"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_api_management.this.id
    subresource_names              = ["Gateway"]
  }

  dynamic "private_dns_zone_group" {
    for_each = var.create_private_dns_record ? [1] : []
    content {
      name                 = "pdzg-$(var.prefix)-${var.name}"
      private_dns_zone_ids = [data.azurerm_private_dns_zone.dnszone[0].id]
    }
  }
  tags = var.tags
}