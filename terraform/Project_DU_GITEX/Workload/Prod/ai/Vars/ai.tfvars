rg_creation                 = "new"
ai_rg_location              = "UAE North"
speech_rg_location          = "Southeast Asia"
ai_search_sku               = "standard"
authentication_failure_mode = "http403"
ai_search_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "AI Search"
  "Business Unit Code" = "DPS"
  "Tier"               = "AI Services"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Prod"
  "Environment Type"   = "Production"
  "Architecture Type"  = "PaaS"
}
document_intelligence_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Azure Cognitive Service"
  "Business Unit Code" = "DPS"
  "Tier"               = "AI Services"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Prod"
  "Environment Type"   = "Production"
  "Architecture Type"  = "PaaS"
}
translator_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Azure Cognitive Service"
  "Business Unit Code" = "DPS"
  "Tier"               = "AI Services"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Prod"
  "Environment Type"   = "Production"
  "Architecture Type"  = "PaaS"
}
speech_service_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Azure Cognitive Service"
  "Business Unit Code" = "DPS"
  "Tier"               = "AI Services"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Prod"
  "Environment Type"   = "Production"
  "Architecture Type"  = "PaaS"
}

identity_type                         = "UserAssigned"
document_intelligence_sku_name        = "S0"
speech_service_sku                    = "S0"
tenant_name                           = "ict"
bu_name                               = "gitex"
environment                           = "prod"
pep_subnet_name                       = "ict-platform-gitex-prod-pep-snet-uaen"
pep_virtual_network_name              = "ict-platform-gitex-prod-vnet-uaen"
pep_resource_group_name               = "ict-platform-gitex-prod-network-rg"
ai_search_private_dns_zone_id         = ["/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08/resourceGroups/ict-platform-hrbot-hub-network-rg/providers/Microsoft.Network/privateDnsZones/privatelink.search.windows.net"]
cognitive_account_private_dns_zone_id = ["/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08/resourceGroups/ict-platform-hrbot-hub-network-rg/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"]
log_analytics_workspace_id      = "/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08/resourceGroups/ict-platform-hrbot-shared-monitor-rg/providers/Microsoft.OperationalInsights/workspaces/ict-platform-hrbot-shared-law"
key_vault_name                        = "ict-plat-gitex-prod-kv"
data_resource_group_name              = "ict-platform-gitex-prod-data-rg"
key_vault_key_name                    = ["ict-platform-gitex-di-cmk", "ict-platform-gitex-trans-cmk", "ict-platform-gitex-spch-cmk"]
uaid_name                             = "ict-platform-gitex-prod-uaid"
translator_service_sku                = "S1"

