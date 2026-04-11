resource "azurerm_private_dns_resolver_inbound_endpoint" "this" {
  name                    = var.name
  private_dns_resolver_id = var.private_dns_resolver_id
  location                = var.location

  dynamic "ip_configurations" {
    for_each = var.ip_configurations
    content {
      private_ip_allocation_method = ip_configurations.value.private_ip_allocation_method
      subnet_id                    = ip_configurations.value.subnet_id
    }
  }

  tags = var.tags
}
