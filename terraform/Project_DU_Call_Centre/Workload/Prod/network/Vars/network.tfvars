address_space_vnet                 = ["10.81.54.0/24"]
subnet_apim_address_prefix         = ["10.81.54.64/26"]
subnet_pep_address_prefix          = ["10.81.54.0/27"]
subnet_compute_address_prefix      = ["10.81.54.32/27"]
subscription_id                    = "b092ed20-9480-45e1-a96c-8b307bfa9eab"
location                           = "UAE North"
tenant_name                        = "ict"
bu_name                            = "cog"
location_shortname                 = "uaen"
hub_vnet_id                        = "/subscriptions/0207aa1d-1c80-483b-9e70-960963c72cda/resourceGroups/ict-platform-shrd-hub-network-rg-uaen-01/providers/Microsoft.Network/virtualNetworks/ict-platform-shrd-hub-vnet-uaen-01"
hub_rg_name                        = "ict-platform-shrd-hub-network-rg-uaen-01"
hub_vnet_name                      = "ict-platform-shrd-hub-vnet-uaen-01"
dns_server                         = ["10.81.48.4"]
hub_subscription_id                = "0207aa1d-1c80-483b-9e70-960963c72cda"
spoke_subscription_id              = "b092ed20-9480-45e1-a96c-8b307bfa9eab"
subnet_routetable_association      = true
subnet_nsg_association             = true
subnet_apim_routetable_association = false
subnet_apim_nsg_association        = true
tags = {
  "Workload Category"  = "Internal Workloads"
  "Business Unit Code" = "DPS"
  "Workload Architype" = "Internal Platform"
  "Tier"               = "Networking"
  "Environment"        = "Prod"
  "Environment Type"   = "Production"
  "Architecture Type"  = "IaaS"
}
vnet_tags = {
  "Workload Name" = "Cognitive Vnet"
}

rt_tags = {
  "Workload Name" = "Cognitive route table"
}

nsg_tags = {
  "Workload Name" = "Cognitive network security group"
}

apim_public_ip = {
  allocation_method = "Static"
  domain_name_label = "ict-platform-cog-prd-apim-uaen-01"
  sku               = "Standard"
  tags              = {}
}
