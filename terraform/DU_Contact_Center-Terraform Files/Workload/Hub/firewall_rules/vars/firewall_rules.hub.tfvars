rg_location              = "UAE North"
rg_creation              = "new"
environment              = "shrd-hub"
tenant_name              = "ict"
ip_sku                   = "Standard"
Sku_Name                 = "AZFW_VNet"
Sku_Tier                 = "Standard"
Subnet_Allocation_Method = "Static"
PIP_Sku                  = "Standard"
workload_type            = "network"
location_shortname       = "uaen"
dns_servers              = ["10.81.49.4"] #DNS server IP

firewall_application_action                   = "Allow"
firewall_application_priority                 = 35510
firewall_network_action                       = "Allow"
firewall_network_priority                     = 3510
firewall_policy_rule_priority                 = 1000
firewall_policy_name                          = "ict-platform-shrd-hub-afw-policy-uaen-01"
hub_network_rg_name                           = "ict-platform-shrd-hub-network-rg-uaen-01"
rule_collection_group_priority_shrd_hub       = 2010
application_rule_collection_priority_shrd_hub = 35510
network_rule_collection_priority_shrd_hub     = 3510
network_rule_collection_shrd_hub_action       = "Allow"
application_rule_collection_shrd_hub_action   = "Allow"

rule_collection_group_priority_cognitive       = 2030
application_rule_collection_priority_cognitive = 35510
network_rule_collection_priority_cognitive     = 3510
network_rule_collection_cognitive_action       = "Allow"
application_rule_collection_cognitive_action   = "Allow"

firewall_policy_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Azure Firewall Policy"
  "Business Unit Code" = "DPS"
  "Tier"               = "Security"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "PaaS"
}
firewall_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Azure Firewall"
  "Business Unit Code" = "DPS"
  "Tier"               = "Security"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hubv"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "PaaS"
}
PIP_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Public IP"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "PaaS"
}


