monitor_resource_group_location = "UAE North"
law_retention_days              = 30
tenant_name                     = "ict"
environment                     = "shrd-hub"
rg_creation                     = "new"
workload_type      = "law"
location_shortname = "uaen"
law_tags = {
  "Workload Category"  = "Internal Workloads"
  "Business Unit Code" = "DPS"
  "Workload Architype" = "Internal Platform"
  "Tier"               = "Monitoring"
  "Environment"        = "hub"
  "Environment Type"   = "hub"
  "Workload Name"      = "Log analytics workspace"
  "Architecture Type"  = "PaaS"
}

resource_group_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Resource_Group"
  "Business Unit Code" = "DPS"
  "Tier"               = "Monitoring"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "IaaS"
}