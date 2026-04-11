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

variable "dns_servers" {
  type = list(string)
  description = "IP of DNS Server"
}

# The priority of the rule collection group for CCAI Dev firewall policy.
# Lower numbers indicate higher priority.
variable "rule_collection_group_priority_shrd_hub" { 
  type        = number
  description = "The priority of the rule collection group for CCAI Dev firewall policy. Lower numbers indicate higher priority."
}

# The priority of the application rule collection for CCAI Dev.
# Lower numbers indicate higher priority.
variable "application_rule_collection_priority_shrd_hub" {
  type        = number
  description = "The priority of the application rule collection for CCAI Dev. Lower numbers indicate higher priority."
}

# The action to take for the application rule collection for CCAI Dev.
# Valid values are 'Allow' or 'Deny'.
variable "application_rule_collection_shrd_hub_action" {
  type        = string
  description = "The action to take for the application rule collection for CCAI Dev. Valid values are 'Allow' or 'Deny'."
}

# The priority of the network rule collection for CCAI Dev.
# Lower numbers indicate higher priority.
variable "network_rule_collection_priority_shrd_hub" {
  type        = number
  description = "The priority of the network rule collection for CCAI Dev. Lower numbers indicate higher priority."
}

# The action to take for the network rule collection for CCAI Dev.
# Valid values are 'Allow' or 'Deny'.
variable "network_rule_collection_shrd_hub_action" {
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
# # Lower numbers indicate higher priority.
variable "application_rule_collection_priority_cognitive" {
  type        = number
  description = "The priority of the application rule collection for Cognitive. Lower numbers indicate higher priority."
}

# # The action to take for the application rule collection for Cognitive.
# # Valid values are 'Allow' or 'Deny'.
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

# # The action to take for the network rule collection for Cognitive.
# Valid values are 'Allow' or 'Deny'.
variable "network_rule_collection_cognitive_action" {
  type        = string
  description = "The action to take for the network rule collection for Cognitive. Valid values are 'Allow' or 'Deny'."
}

# Typically used to define the size or type of Azure Firewall in a Virtual Network.
variable "Sku_Name" {
  type        = string
  description = "Specifies the SKU (Stock Keeping Unit) name for the resource, typically used to define the size or type of Azure Firewall in a Virtual Network."
}

# Defines the tier of the SKU for the resource.
# This might include tiers such as Standard, Premium, etc., based on the resource type.
variable "Sku_Tier" {
  type        = string
  description = "Defines the tier of the SKU for the resource."
}

# Tags associated with the firewall policy, useful for organizing and managing resources.
variable "firewall_policy_tags" {
  type        = map(string)
  description = "Tags for the firewall policy, used to organize and manage the policy in Azure."
}

# Tags associated with the firewall, useful for organizing and managing resources.
variable "firewall_tags" {
  type        = map(string)
  description = "Tags to be applied for the azure firewall."
}

# Tags associated with the public ip.
variable "PIP_tags" {
  type        = map(string)
  description = "Tags to be applied for the public ip."
}

# Specifies the allocation method for the IP address in the subnet.
# Common values include "Dynamic" or "Static" allocation for IP addresses.
variable "Subnet_Allocation_Method" {
  type        = string
  description = "Specifies the allocation method for the IP address in the subnet."
}

# Defines the SKU tier for the subnet, used for defining performance or capacity in certain configurations.
variable "PIP_Sku" {
  type        = string
  description = "Defines the SKU tier for the subnet."
}

# The geographical location where the resource group will be deployed.
variable "rg_location" {
  type        = string
  description = "Location of the resource group."
}


# A flag to indicate whether the resource group should be created.
variable "rg_creation" {
  type        = string
  description = "Flag to indicate whether a new resource group should be created or existing resource group is used."
}

# Variable for the tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the tenant."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "workload_type" {
  type        = string
  description = "workload type of the resource"
}

# Variable for the location name
variable "location_shortname" {
  type        = string
  description = "The geographical location of the resource."
}
 