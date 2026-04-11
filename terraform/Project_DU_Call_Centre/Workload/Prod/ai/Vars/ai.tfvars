rg_creation            = "new"
ai_rg_location         = "uaenorth"
tenant_name            = "ict"
environment            = "prod"
bu_name                = "ccai"
translator_service_sku = "DC0"
language_service_sku   = "DC0"
speech_service_sku     = "DC0"
sku_name               = "S0"
deployment_name        = "gpt4o-2024-08-06"
ptu_sku_name           = "ProvisionedManaged"
ptu_sku_capacity       = 150
model_format           = "OpenAI"
model_name             = "gpt-4o"
model_version          = "2024-11-20"
# model_version          = "2024-08-06"

hub_pep_subnet_id = "/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/virtualNetworks/ict-platform-shrd-hub-vnet-uaen-01/subnets/ict-platform-shrd-hub-pep-snet-uaen-01"
hub_pep_subnet_name          = "ict-platform-shrd-hub-pep-snet-uaen-01"
hub_pep_virtual_network_name = "ict-platform-shrd-hub-vnet-uaen-01"
hub_pep_resource_group_name  = "ict-platform-shrd-hub-network-rg-uaen-01"

latest_deployment_name  = "gpt-4o-latest"
latest_ptu_sku_name     = "ProvisionedManaged"
latest_ptu_sku_capacity = 100
latest_model_format     = "OpenAI"
latest_model_name       = "gpt-4o"
latest_model_version    = "2024-11-20"

identity_type      = "UserAssigned"
key_vault_sku_name = "standard"
key_opts           = ["wrapKey", "unwrapKey"]
key_type           = "RSA"
key_size           = 4096
# key_vault_private_dns_zone_id = [""] 
# subscription_id          = "b092ed20-9480-45e1-a96c-8b307bfa9eab"
pep_subnet_name          = "ict-platform-cog-prd-pep-snet-uaen-01"
pep_virtual_network_name = "ict-platform-cog-prd-vnet-uaen-01"
pep_resource_group_name  = "ict-platform-cog-prd-network-rg-uaen-01"

apim_public_ip_name = "ict-platform-cog-prd-apim-pip-uaen-01"
apim_subnet_name    = "ict-platform-cog-prd-apim-snet-uaen-01"

#common tags to assign
tags = {
  "Workload Category"  = "Internal Workloads"
  "Business Unit Code" = "DPS"
  "Tier"               = "ai"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Shared"
  "Environment Type"   = "Cognitive Services"
  "Architecture Type"  = "PaaS"
}

#Document Intelligence Cognitive Service REQUIRED VARIABLES vaule passed in "di"
document_intelligence_private_dns_zone_ids = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.cognitiveservices.azure.com"]
di = {
  di_kind                          = "FormRecognizer"
  di_skuname                       = "S0"
  pep_target_subresources          = ["account"] # value used in di Document Intelligence private endpoint.
  public_network_access_enabled_di = true
  identity_type                    = "UserAssigned"
  di_tags = {
    "Workload Name" = "Document-Intelligence"
  }
}

# # ML Compute instance private Subnet values.
# ml_compute_instance_subnet_name = "ict-platform-cognitive-ml-snet-uaen"
# ml_compute_instance_vnet_name   = "ict-platform-cognitive-vnet-uaen"
# ml_compute_instance_network_rg  = "ict-platform-cognitive-network-rg"

# Log analytics workspace values
log_analytics_workspace_name      = "ict-platform-cognitive-law"
log_analytics_resource_group_name = "ict-platform-cognitive-monitoring-rg"

# #Private DNS Zones of Storage account
# adls_blob_private_dns_zone_id = ["/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08/resourceGroups/ict-platform-hrbot-hub-network-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]
# adls_dfs_private_dns_zone_id  = ["/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08/resourceGroups/ict-platform-hrbot-hub-network-rg/providers/Microsoft.Network/privateDnsZones/privatelink.dfs.core.windows.net"]
# adls_file_private_dns_zone_id = ["/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08/resourceGroups/ict-platform-hrbot-hub-network-rg/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"]

# key_vault_private_dns_zone_id = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"]
# acr_private_dns_zone_id       = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io"]
 hub_acr_private_dns_zone_id       = ["/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io"]

#Private DNS Zones of Azure ML Workspace
# ml_workspace_private_dns_zone_id = [
#   "/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08/resourceGroups/ict-platform-hrbot-hub-network-rg/providers/Microsoft.Network/privateDnsZones/privatelink.api.azureml.ms",
#   "/subscriptions/c8b99861-fdf5-4f0c-8f85-e75b141fca08/resourceGroups/ict-platform-hrbot-hub-network-rg/providers/Microsoft.Network/privateDnsZones/privatelink.notebooks.azure.net"
# ]

#use the below ml_vm_configs block to pass VM variable values. 
# ml_vm_configs = {
#   mlwci01-vm = { #VM name get create using local value "${var.tenant_name}-${var.bu_name}-${vm_key} + mlwci01-vm
#     ml_compute_vm_size     = "Standard_D3_v2"
#     node_public_ip_enabled = false
#     object_id_user         = "" #update user AAD Object ID who will work on this Compute Instance.
#     tenant_id              = "" #Azure tenant id where user ID Exists.
#     ml_compute_tags = {
#       "Tier"               = "Compute"
#       "Architecture Type"  = "IaaS"
#       "Workload Name"      = "ml-compute-instance"
#       "Workload Category"  = "Internal Workloads"
#       "Business Unit Code" = "DPS"
#       "Workload Architype" = "Internal Platform"
#       "Environment"        = "Shared"
#       "Environment Type"   = "Cognitive Services"
#     }
#   }
#   mlwci02-vm = { # #VM name get create using local value "${var.tenant_name}-${var.bu_name}-${vm_key} + mlwci02-vm
#     ml_compute_vm_size     = "Standard_D3_v2"
#     node_public_ip_enabled = false
#     object_id_user         = "" #update user AAD Object ID who will work on this Compute Instance.
#     tenant_id              = "" #Azure tenant id where user ID Exists.
#     ml_compute_tags = {
#       "Tier"               = "Compute"
#       "Architecture Type"  = "IaaS"
#       "Workload Name"      = "ml-compute-instance"
#       "Workload Category"  = "Internal Workloads"
#       "Business Unit Code" = "DPS"
#       "Workload Architype" = "Internal Platform"
#       "Environment"        = "Shared"
#       "Environment Type"   = "Cognitive Services"
#     }
#   }
#   mlwci03-vm = { # #VM name get create using local value "${var.tenant_name}-${var.bu_name}-${vm_key} + mlwci03-vm
#     ml_compute_vm_size     = "Standard_D3_v2"
#     node_public_ip_enabled = false
#     object_id_user         = "" #update user AAD Object ID who will work on this Compute Instance.
#     tenant_id              = "" #Azure tenant id where user ID Exists.
#     ml_compute_tags = {
#       "Tier"               = "Compute"
#       "Architecture Type"  = "IaaS"
#       "Workload Name"      = "ml-compute-instance"
#       "Workload Category"  = "Internal Workloads"
#       "Business Unit Code" = "DPS"
#       "Workload Architype" = "Internal Platform"
#       "Environment"        = "Shared"
#       "Environment Type"   = "Cognitive Services"
#     }
#   }
#   mlwci04-vm = { # #VM name get create using local value "${var.tenant_name}-${var.bu_name}-${vm_key} + mlwci04-vm
#     ml_compute_vm_size     = "Standard_D3_v2"
#     node_public_ip_enabled = false
#     object_id_user         = "" #update user AAD Object ID who will work on this Compute Instance.
#     tenant_id              = "" #Azure tenant id where user ID Exists.
#     ml_compute_tags = {
#       "Tier"               = "Compute"
#       "Architecture Type"  = "IaaS"
#       "Workload Name"      = "ml-compute-instance"
#       "Workload Category"  = "Internal Workloads"
#       "Business Unit Code" = "DPS"
#       "Workload Architype" = "Internal Platform"
#       "Environment"        = "Shared"
#       "Environment Type"   = "Cognitive Services"
#     }
#   }
# }

embedding_deployment_name = "text-embedding-ada-002"
embedding_sku_name        = "Standard"
embedding_model_name      = "text-embedding-ada-002"
embedding_model_version   = "2"
embedding_sku_capacity    = "120"
law_name                  = "ict-platform-cognitive-law"
law_rg_name               = "ict-platform-cognitive-monitoring-rg"

#Ai Search
customer_managed_key_enforcement_enabled = false
ai_search_sku                            = "standard"
authentication_failure_mode              = "http403"
search_identity_type                     = "SystemAssigned"
semantic_search_sku                      = "standard"
ai_search_tags = {
  "Workload Name" = "AI Search"
}

# Azure Container Registry.
container_registry = {
  sku                           = "Premium"
  public_network_access_enabled = true
  identity = {
    type = "SystemAssigned"
  }
  tags = {
    "Workload Name" = "ACR"
  }
}

apim_config = {
  publisher_name                = "du"
  publisher_email               = "vishal.choudhary@celebaltech.com"
  sku_name                      = "Premium_1"
  public_network_access_enabled = true
  virtual_network_type          = "External"
  tags                          = {}
  identity = {
    type = "SystemAssigned"
  }
}
