location                                   = "UAE North"
tenant_name                                = "ict"
environment                                = "shrd-hub"
key_vault_sku_name                         = "standard"
pep_subnet_name                            = "ict-platform-shrd-hub-pep-snet-uaen-01"
pep_virtual_network_name                   = "ict-platform-shrd-hub-vnet-uaen-01"
pep_resource_group_name                    = "ict-platform-shrd-hub-network-rg-uaen-01" 
key_vault_private_dns_zone_id              = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"]
rg_creation        = "new"
workload_type      = "data"
location_shortname = "uaen"
tags = {
  "Workload Category"  = "Internal Workloads"
  "Business Unit Code" = "DPS"
  "Tier"               = "Data"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "hub"
  "Environment Type"   = "hub"
  "Architecture Type"  = "PaaS"
}

resource_group_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Resource_Group"
  "Business Unit Code" = "DPS"
  "Tier"               = "Key-Vault"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "IaaS"
}

# key_opts = ["wrapKey", "unwrapKey"]
# key_type = "RSA"
# key_size = 4096
 
# #Private DNS Zones of Storage account
# adls_blob_private_dns_zone_id = ["/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08/resourceGroups/ict-platform-hrbot-hub-network-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]
# adls_dfs_private_dns_zone_id  = ["/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08/resourceGroups/ict-platform-hrbot-hub-network-rg/providers/Microsoft.Network/privateDnsZones/privatelink.dfs.core.windows.net"]
# adls_file_private_dns_zone_id = ["/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08/resourceGroups/ict-platform-hrbot-hub-network-rg/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"]
# key_vault_private_dns_zone_id = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"]
# acr_private_dns_zone_id       = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io"]
# document_intelligence_private_dns_zone_ids = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"]
