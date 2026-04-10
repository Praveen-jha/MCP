variable "application_rule_name" {
  type        = string
  description = "The specific name of the application rule to be used or created."
}

variable "application_rule_action" {
  type        = string
  description = "The action for the application rule, typically 'Allow' or 'Deny'."
}

variable "application_rule_priority" {
  type        = number
  description = "Priority for the rule, with lower numbers indicating higher priority."
}

variable "application_rules" {
  type = list(object({
    name              = string
    source_addresses  = list(string)
    destination_fqdns = list(string)
    port              = string
    type              = string
  }))
  description = "List of application rules for the firewall, defining name, source addresses, target FQDNs, port, and rule type."
}

variable "network_rule_name" {
  type        = string
  description = "The specific name of the Network rule to be used or created."
}

variable "network_rule_action" {
  type        = string
  description = "The action for the application rule."
}

variable "network_rule_priority" {
  type        = number
  description = "Priority for the rule, with lower numbers indicating higher priority."
}

variable "network_rules" {
  type = list(object({
    name                  = string
    source_addresses      = list(string)
    destination_ports     = list(string)
    destination_addresses = list(string)
    protocols             = list(string)
  }))
}

variable "firewall_policy_rule_collection_name" {
  type = string
  description = "Name of firewall policy rule collection"
}

variable "azure_firewall_policy_id" {
  type = string
  description = "Azure firewall policy id"
}

variable "firewall_policy_rule_priority" {
  type = number
  description = "Priority for the rule, with lower numbers indicating higher priority."
}
