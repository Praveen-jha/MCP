resource "azurerm_private_dns_resolver_outbound_endpoint" "this" {
  name                    = var.name
  private_dns_resolver_id = var.private_dns_resolver_id
  location                = var.location
  subnet_id               = var.subnet_id
  tags                    = var.tags
}
