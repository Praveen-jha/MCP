# ......................................................
# Creating Firewall Policy rules.
# ......................................................

module "firewall_policy_rule" {
  source                               = "../../../Modules/firewall_policy_rule_collection"
  firewall_policy_rule_collection_name = local.firewall_policy_rule_collection_name
  azure_firewall_policy_id             = data.azurerm_firewall_policy.firewall_policy_id.id
  firewall_policy_rule_priority        = var.firewall_policy_rule_priority
  application_rule_name                = local.firewall_application_rule_name
  application_rule_priority            = var.firewall_application_priority
  application_rule_action              = var.firewall_application_action
  application_rules                    = local.firewall_application_rules
  network_rule_name                    = local.firewall_network_rule_name
  network_rule_priority                = var.firewall_network_priority
  network_rule_action                  = var.firewall_network_action
  network_rules                        = local.firewall_network_rules
}

# ......................................................
# Creating Firewall Policy rules for Gitex Environment.
# ......................................................

module "firewall_policy_rule_gitex" {
  source                               = "../../../Modules/firewall_policy_rule_collection_group"
  firewall_policy_rule_collection_name = local.rule_collection_group_name_gitex
  azure_firewall_policy_id             = data.azurerm_firewall_policy.firewall_policy_id.id
  firewall_policy_rule_priority        = var.rule_collection_group_priority_gitex
  application_rule_name                = local.application_rule_collection_name_gitex
  application_rule_priority            = var.application_rule_collection_priority_gitex
  application_rule_action              = var.application_rule_collection_action_gitex
  application_rules                    = local.application_rules_gitex
  network_rule_name                    = local.network_rule_collection_name_gitex
  network_rule_priority                = var.network_rule_collection_priority_gitex
  network_rule_action                  = var.network_rule_collection_gitex_action
  network_rules                        = local.firewall_network_rules_gitex
}

# ......................................................
# Creating Firewall Policy rules for CCAI Dev environment.
# ......................................................

module "firewall_policy_rule_ccai_dev" {
  source                               = "../../../Modules/firewall_policy_rule_collection_group"
  firewall_policy_rule_collection_name = local.rule_collection_group_name_ccai_dev
  azure_firewall_policy_id             = data.azurerm_firewall_policy.firewall_policy_id.id
  firewall_policy_rule_priority        = var.rule_collection_group_priority_ccai_dev
  application_rule_name                = local.application_rule_collection_name_ccai_dev
  application_rule_priority            = var.application_rule_collection_priority_ccai_dev
  application_rule_action              = var.application_rule_collection_ccai_dev_action
  application_rules                    = local.application_rules_ccai_dev
  network_rule_name                    = local.network_rule_collection_name_ccai_dev
  network_rule_priority                = var.network_rule_collection_priority_ccai_dev
  network_rule_action                  = var.network_rule_collection_ccai_dev_action
  network_rules                        = local.network_rules_ccai_dev
}

# ......................................................
# Creating Firewall Policy rules for Cognitive environment.
# ......................................................

module "firewall_policy_rule_cognitive" {
  source                               = "../../../Modules/firewall_policy_rule_collection_group"
  firewall_policy_rule_collection_name = local.rule_collection_group_name_cognitive
  azure_firewall_policy_id             = data.azurerm_firewall_policy.firewall_policy_id.id
  firewall_policy_rule_priority        = var.rule_collection_group_priority_cognitive
  application_rule_name                = local.application_rule_collection_name_cognitive
  application_rule_priority            = var.application_rule_collection_priority_cognitive
  application_rule_action              = var.application_rule_collection_cognitive_action
  application_rules                    = local.application_rules_cognitive
  network_rule_name                    = local.network_rule_collection_name_cognitive
  network_rule_priority                = var.network_rule_collection_priority_cognitive
  network_rule_action                  = var.network_rule_collection_cognitive_action
  network_rules                        = local.network_rules_cognitive
}