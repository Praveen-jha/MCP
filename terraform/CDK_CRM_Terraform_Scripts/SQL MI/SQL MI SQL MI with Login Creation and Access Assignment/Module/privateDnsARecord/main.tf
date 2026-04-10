resource "azurerm_private_dns_a_record" "example" {
  name                = var.private_dns_record_name
  zone_name           = var.private_dns_zone_name
  resource_group_name = var.private_dns_zone_resource_group_name
  ttl                 = 3600
  records             = var.records
}

