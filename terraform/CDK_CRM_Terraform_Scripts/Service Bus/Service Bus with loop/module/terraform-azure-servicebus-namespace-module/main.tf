# Module: terraform_azure_servicebus_namespace
# Description: Terraform module for Azure Service Bus Namespace.
# Registry: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace

resource "azurerm_servicebus_namespace" "this" {
  name                          = var.servicebus_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.sku
  capacity                      = var.capacity
  premium_messaging_partitions  = var.premium_messaging_partitions
  local_auth_enabled            = var.local_auth_enabled
  public_network_access_enabled = var.public_network_access_enabled
  minimum_tls_version           = var.minimum_tls_version
  tags                          = var.tags

  dynamic "identity" {
    for_each = var.identity == null ? [] : [var.identity]
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  dynamic "customer_managed_key" {
    for_each = var.customer_managed_key == null ? [] : [var.customer_managed_key]
    content {
      key_vault_key_id                  = customer_managed_key.value.key_vault_key_id
      identity_id                       = customer_managed_key.value.identity_id
      infrastructure_encryption_enabled = lookup(customer_managed_key.value, "infrastructure_encryption_enabled", null)
    }
  }

  dynamic "network_rule_set" {
    for_each = var.network_rule_set == null ? [] : [var.network_rule_set]
    content {
      default_action                = network_rule_set.value.default_action
      public_network_access_enabled = lookup(network_rule_set.value, "public_network_access_enabled", true)
      trusted_services_allowed      = lookup(network_rule_set.value, "trusted_services_allowed", false)
      ip_rules                      = lookup(network_rule_set.value, "ip_rules", [])

      dynamic "network_rules" {
        for_each = lookup(network_rule_set.value, "network_rules", [])
        content {
          subnet_id                            = network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = lookup(network_rules.value, "ignore_missing_vnet_service_endpoint", false)
        }
      }
    }
  }
}
