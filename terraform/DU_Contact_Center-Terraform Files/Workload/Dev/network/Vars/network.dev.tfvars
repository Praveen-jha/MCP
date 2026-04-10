address_space_vnet        = ["10.81.50.0/24"]
subnet_pep_address_prefix = ["10.81.50.0/27"]

hub_subscription_id = "0207aa1d-1c80-483b-9e70-960963c72cda"
dev_subscription_id = "aefbbd9d-b129-461a-9571-c4b91e70e6a8"
hub_vnet_id         = "/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/virtualNetworks/ict-platform-shrd-hub-vnet-uaen-01"
hub_rg_name         = "ict-platform-shrd-hub-network-rg-uaen-01"
hub_vnet_name       = "ict-platform-shrd-hub-vnet-uaen-01"

vnet_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Dev_Vnet"
  "Tier"               = "Networking"
  "Business Unit Code" = "DPS"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Dev"
  "Environment Type"   = "Dev"
  "Architecture Type"  = "IaaS"
}


rt_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Dev_Route_Table"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Dev"
  "Environment Type"   = "Dev"
  "Architecture Type"  = "IaaS"
}

nsg_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Network_security_group"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Dev"
  "Environment Type"   = "Dev"
  "Architecture Type"  = "IaaS"
}
resource_group_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Resource_Group"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Dev"
  "Environment Type"   = "Dev"
  "Architecture Type"  = "IaaS"
}

rg_location        = "UAE North"
rg_creation        = "new"
environment        = "ccai-dev"
tenant_name        = "ict"
workload_type      = "network"
custom_dns_ip      = ["10.81.48.4"]
location_shortname = "uaen"

 
