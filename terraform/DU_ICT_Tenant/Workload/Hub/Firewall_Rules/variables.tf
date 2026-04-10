# Defines the action (e.g., "Allow" or "Deny") for the firewall application rule.
variable "firewall_application_action" {
  type        = string
  description = "The action for the application rule."
}

# Specifies the priority level for the firewall application rule collection. 
# Lower numbers indicate higher priority.
variable "firewall_application_priority" {
  type        = number
  description = "Priority for the application rule, with lower numbers indicating higher priority."
}

# Defines the action (e.g., "Allow" or "Deny") for the firewall network rule.
variable "firewall_network_action" {
  type        = string
  description = "The action for the network rule."
}

# Specifies the priority level for the firewall network rule collection. 
# Lower numbers indicate higher priority.
variable "firewall_network_priority" {
  type        = number
  description = "Priority for the network rule, with lower numbers indicating higher priority."
}

# General priority setting for firewall policy rules.
# Lower numbers indicate higher priority within the firewall policy.
variable "firewall_policy_rule_priority" {
  type        = number
  description = "Priority for the firewall policy rule, with lower numbers indicating higher priority."
}

variable "firewall_policy_name" {
  type        = string
  description = "Name of Azure Firewall Policy"
}

# The name of the resource group where the hub network is located.
variable "hub_network_rg_name" {
  type        = string
  description = "The name of the resource group for the hub network."
}

# The priority of the rule collection group for Gitex firewall policy.
# Lower numbers indicate higher priority.
variable "rule_collection_group_priority_gitex" {
  type        = number
  description = "The priority of the rule collection group for Gitex firewall policy. Lower numbers indicate higher priority."
}

# The priority of the application rule collection for Gitex.
# Lower numbers indicate higher priority.
variable "application_rule_collection_priority_gitex" {
  type        = number
  description = "The priority of the application rule collection for Gitex. Lower numbers indicate higher priority."
}

# The action to take for the application rule collection for Gitex.
# Valid values are 'Allow' or 'Deny'.
variable "application_rule_collection_action_gitex" {
  type        = string
  description = "The action to take for the application rule collection for Gitex. Valid values are 'Allow' or 'Deny'."
}

# The priority of the network rule collection for Gitex.
# Lower numbers indicate higher priority.
variable "network_rule_collection_priority_gitex" {
  type        = number
  description = "The priority of the network rule collection for Gitex. Lower numbers indicate higher priority."
}

# The action to take for the network rule collection for Gitex.
# Valid values are 'Allow' or 'Deny'.
variable "network_rule_collection_gitex_action" {
  type        = string
  description = "The action to take for the network rule collection for Gitex. Valid values are 'Allow' or 'Deny'."
}

# The priority of the rule collection group for CCAI Dev firewall policy.
# Lower numbers indicate higher priority.
variable "rule_collection_group_priority_ccai_dev" { 
  type        = number
  description = "The priority of the rule collection group for CCAI Dev firewall policy. Lower numbers indicate higher priority."
}

# The priority of the application rule collection for CCAI Dev.
# Lower numbers indicate higher priority.
variable "application_rule_collection_priority_ccai_dev" {
  type        = number
  description = "The priority of the application rule collection for CCAI Dev. Lower numbers indicate higher priority."
}

# The action to take for the application rule collection for CCAI Dev.
# Valid values are 'Allow' or 'Deny'.
variable "application_rule_collection_ccai_dev_action" {
  type        = string
  description = "The action to take for the application rule collection for CCAI Dev. Valid values are 'Allow' or 'Deny'."
}

# The priority of the network rule collection for CCAI Dev.
# Lower numbers indicate higher priority.
variable "network_rule_collection_priority_ccai_dev" {
  type        = number
  description = "The priority of the network rule collection for CCAI Dev. Lower numbers indicate higher priority."
}

# The action to take for the network rule collection for CCAI Dev.
# Valid values are 'Allow' or 'Deny'.
variable "network_rule_collection_ccai_dev_action" {
  type        = string
  description = "The action to take for the network rule collection for CCAI Dev. Valid values are 'Allow' or 'Deny'."
}

# The priority of the rule collection group for Cognitive firewall policy.
# Lower numbers indicate higher priority.
variable "rule_collection_group_priority_cognitive" {
  type        = number
  description = "The priority of the rule collection group for Cognitive firewall policy. Lower numbers indicate higher priority."
}

# The priority of the application rule collection for Cognitive.
# Lower numbers indicate higher priority.
variable "application_rule_collection_priority_cognitive" {
  type        = number
  description = "The priority of the application rule collection for Cognitive. Lower numbers indicate higher priority."
}

# The action to take for the application rule collection for Cognitive.
# Valid values are 'Allow' or 'Deny'.
variable "application_rule_collection_cognitive_action" {
  type        = string
  description = "The action to take for the application rule collection for Cognitive. Valid values are 'Allow' or 'Deny'."
}

# The priority of the network rule collection for Cognitive.
# Lower numbers indicate higher priority.
variable "network_rule_collection_priority_cognitive" {
  type        = number
  description = "The priority of the network rule collection for Cognitive. Lower numbers indicate higher priority."
}

# The action to take for the network rule collection for Cognitive.
# Valid values are 'Allow' or 'Deny'.
variable "network_rule_collection_cognitive_action" {
  type        = string
  description = "The action to take for the network rule collection for Cognitive. Valid values are 'Allow' or 'Deny'."
}