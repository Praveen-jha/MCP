resource "azurerm_firewall_policy_rule_collection_group" "firewall_policy_rule_collection" {
  name               = var.firewall_policy_rule_collection_name
  firewall_policy_id = var.azure_firewall_policy_id
  priority           = var.firewall_policy_rule_priority

  application_rule_collection {
    name     = var.application_rule_name
    priority = var.application_rule_priority
    action   = var.application_rule_action

    dynamic "rule" {
      for_each = var.application_rules

      content {
        name              = rule.value.name
        source_addresses  = rule.value.source_addresses
        destination_fqdns = rule.value.destination_fqdns

        protocols {
          port = rule.value.port
          type = rule.value.type
        }
      }
    }
  }

  network_rule_collection {
    name     = var.network_rule_name
    priority = var.network_rule_priority
    action   = var.network_rule_action

    dynamic "rule" {
      for_each = var.network_rules

      content {
        name                  = rule.value.name
        source_addresses      = rule.value.source_addresses
        destination_ports     = rule.value.destination_ports
        destination_addresses = rule.value.destination_addresses
        protocols             = rule.value.protocols
      }
    }
  }
}
