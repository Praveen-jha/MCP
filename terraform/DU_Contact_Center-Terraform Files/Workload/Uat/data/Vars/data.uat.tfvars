location           = "UAE North"
tenant_name        = "ict"
environment        = "ccai-uat"
rg_creation        = "new"
workload_type      = "data"
location_shortname = "uaen"
subscription_id    = "3cce6d8c-6f7d-49c5-90df-30e0797d6e59"

tags = {
  "Workload Category"  = "Internal Workloads"
  "Business Unit Code" = "DPS"
  "Tier"               = "Data"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "UAT"
  "Environment Type"   = "UAT"
  "Architecture Type"  = "PaaS"
}

resource_group_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Resource_Group"
  "Business Unit Code" = "DPS"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "UAT"
  "Environment Type"   = "UAT"
  "Architecture Type"  = "IaaS"
}

apim_config = {
  subnet_name                   = "ict-platform-ccai-uat-apim-snet-uaen-01"
  virtual_network_name          = "ict-platform-ccai-uat-vnet-uaen-01"
  resource_group_name           = "ict-platform-ccai-uat-network-rg-uaen-01"
  publisher_name                = "du"
  publisher_email               = "vishal.choudhary@celebaltech.com"
  sku_name                      = "Developer_1"
  public_network_access_enabled = true
  public_ip_name                = ""
  virtual_network_type          = "External"
  tags                          = {}
  identity = {
    type = "SystemAssigned"
  }
}

# Azure Container Registry.
container_registry = {
  sku                           = "Basic"
  public_network_access_enabled = true
  identity = {
    type = "SystemAssigned"
  }
  tags = {
    "Workload Name" = "ACR"
  }
}