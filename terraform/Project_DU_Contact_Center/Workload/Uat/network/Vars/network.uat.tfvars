rg_creation                = "new"
rg_location                = "UAE North"
environment                = "ccai-uat"
tenant_name                = "ict"
workload_type              = "network"
custom_dns_ip              = []
location_shortname         = "uaen"
address_space_vnet         = ["10.81.51.0/24"]
subnet_apim_address_prefix = ["10.81.51.64/26"]
subscription_id            = "3cce6d8c-6f7d-49c5-90df-30e0797d6e59"
rt_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "UAT_Route_Table"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Uat"
  "Environment Type"   = "Uat"
  "Architecture Type"  = "IaaS"
}

vnet_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "uat_Vnet"
  "Tier"               = "Networking"
  "Business Unit Code" = "DPS"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "UAT"
  "Environment Type"   = "UAT"
  "Architecture Type"  = "IaaS"
}

nsg_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Network_security_group"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "UAT"
  "Environment Type"   = "UAT"
  "Architecture Type"  = "IaaS"
}

resource_group_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Resource_Group"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "UAT"
  "Environment Type"   = "UAT"
  "Architecture Type"  = "IaaS"
}


