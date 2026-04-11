location                                   = "UAE North"
tenant_name                                = "ict"
environment                                = "ccai-dev"
key_vault_sku_name                         = "standard"
pep_subnet_name                            = "ict-platform-ccai-dev-pep-snet-uaen-01"
pep_virtual_network_name                   = "ict-platform-ccai-dev-vnet-uaen-01"
pep_resource_group_name                    = "ict-platform-ccai-dev-network-rg-uaen-01" 
key_vault_private_dns_zone_id              = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"]
rg_creation        = "new"
workload_type      = "data"
location_shortname = "uaen"
tags = {
  "Workload Category"  = "Internal Workloads"
  "Business Unit Code" = "DPS"
  "Tier"               = "Data"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Dev"
  "Environment Type"   = "Dev"
  "Architecture Type"  = "PaaS"
}

resource_group_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Resource_Group"
  "Business Unit Code" = "DPS"
  "Tier"               = "Data"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Dev"
  "Environment Type"   = "Dev"
  "Architecture Type"  = "IaaS"
}

# key_opts = ["wrapKey", "unwrapKey"]
# key_type = "RSA"
# key_size = 4096
 