# ......................................................
# Creating Firewall
# ......................................................

module "Firewall" {
  source                           = "../../../Modules/firewall"
  Firewall_Name                    = local.Firewall_Name
  Sku_Name                         = var.Sku_Name
  Sku_Tier                         = var.Sku_Tier
  Ip_Configuration_name            = local.Ip_Configuration_name
  location                         = local.location
  resource_group_name              = local.resource_group_name
  subnet_id                        = data.azurerm_subnet.subnet.id
  PIP_Name                         = local.PIP_Name
  Subnet_Allocation_Method         = var.Subnet_Allocation_Method
  PIP_Sku                          = var.PIP_Sku
  firewall_policy_name             = local.firewall_policy_name
  firewall_policy_sku              = var.Sku_Tier
  firewall_policy_tags             = var.firewall_policy_tags
  firewall_tags                    = var.firewall_tags
  PIP_tags                         = var.PIP_tags
  management_ip_configuration_name = local.management_ip_configuration_name
  mgnt_PIP_Name                    = local.Mgnt_PIP_Name
  mgnt_subnet_id                   = data.azurerm_subnet.mgnt_subnet.id
  proxy_enabled                    = local.proxy_enabled
  dns_servers                      = var.dns_servers
  depends_on                       = [data.azurerm_subnet.subnet]
}

# ......................................................
# Creating Firewall Policy rules for Hub environment.
# ......................................................

module "firewall_policy_rule_shrd_hub" {
  source                                     = "../../../Modules/firewall_policy_rule_collection_group"
  firewall_policy_rule_collection_group_name = local.rule_collection_group_name_shrd_hub
  azure_firewall_policy_id                   = module.Firewall.firewall_policy_id
  firewall_policy_rule_priority              = var.rule_collection_group_priority_shrd_hub
  application_rule_name                      = local.application_rule_collection_name_shrd_hub
  application_rule_priority                  = var.application_rule_collection_priority_shrd_hub
  application_rule_action                    = var.application_rule_collection_shrd_hub_action
  application_rules                          = local.application_rules_shrd_hub
  network_rule_name                          = local.network_rule_collection_name_shrd_hub
  network_rule_priority                      = var.network_rule_collection_priority_shrd_hub
  network_rule_action                        = var.network_rule_collection_shrd_hub_action
  network_rules                              = local.network_rules_shrd_hub
  depends_on                                 = [module.Firewall]
}

# ......................................................
# Creating Firewall Policy rules for Cognitive environment.
# ...................................................... 
module "firewall_policy_rule_cognitive" {
  source                                     = "../../../Modules/firewall_policy_rule_collection_group"
  firewall_policy_rule_collection_group_name = local.rule_collection_group_name_cognitive
  azure_firewall_policy_id                   = module.Firewall.firewall_policy_id
  firewall_policy_rule_priority              = var.rule_collection_group_priority_cognitive
  application_rule_name                      = local.application_rule_collection_name_cognitive
  application_rule_priority                  = var.application_rule_collection_priority_cognitive
  application_rule_action                    = var.application_rule_collection_cognitive_action
  application_rules                          = local.application_rules_cognitive
  network_rule_name                          = local.network_rule_collection_name_cognitive
  network_rule_priority                      = var.network_rule_collection_priority_cognitive
  network_rule_action                        = var.network_rule_collection_cognitive_action
  network_rules                              = local.network_rules_cognitive
}
