resource "azurerm_network_security_group" "nsg" {
  name                = var.nsgName
  location            = var.location
  resource_group_name = var.rgName
  tags                = var.nsgTags
  dynamic "security_rule" {
    for_each = var.secRule
    content {
      name                         = security_rule.value.name
      protocol                     = security_rule.value.protocol
      source_port_range            = security_rule.value.source_port_range
      destination_port_range       = security_rule.value.destination_port_range
      source_address_prefix        = security_rule.value.source_address_prefix
      source_address_prefixes      = security_rule.value.source_address_prefixes
      destination_address_prefix   = security_rule.value.destination_address_prefix
      destination_address_prefixes = security_rule.value.destination_address_prefixes
      access                       = security_rule.value.access
      priority                     = security_rule.value.priority
      direction                    = security_rule.value.direction
    }
  }
}
