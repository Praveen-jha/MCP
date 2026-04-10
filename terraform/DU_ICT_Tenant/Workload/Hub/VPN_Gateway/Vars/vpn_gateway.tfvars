vpngw_location           = "UAE North"
pip_allocation_method = "Static"
gateway_sku = "VpnGw1"
vpn_type = "RouteBased"
vpn_gw_type = "Vpn"
private_ip_address_allocation = "Dynamic"
enable_active_active = false
enable_bgp = false
pip_sku = "Standard"
# lng_address = "168.62.225.23"
# lng_address_space = ["10.1.1.0/24"]
# s2s_connection_type = "IPsec"
# shared_key = "abc123"

vpngw_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Virtual network Gateway for S2S connectivity"
  "Tier"               = "Networking"
  "Business Unit Code" = "DPS"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Dev"
  "Environment Type"   = "Non Production"
  "Architecture Type"  = "IaaS"
}

pip_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Public IP for virtual network"
  "Tier"               = "Networking"
  "Business Unit Code" = "DPS"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Dev"
  "Environment Type"   = "Non Production"
  "Architecture Type"  = "IaaS"
}

# lng_tags = {
#   "Workload Category"  = "Internal Workloads"
#   "Workload Name"      = "Local network Gateway for S2S connectivity"
#   "Tier"               = "Networking"
#   "Business Unit Code" = "DPS"
#   "Workload Architype" = "Internal Platform"
#   "Environment"        = "Dev"
#   "Environment Type"   = "Non Production"
#   "Architecture Type"  = "IaaS"
# }

# connection_tags = {
#   "Workload Category"  = "Internal Workloads"
#   "Workload Name"      = "S2S connection"
#   "Tier"               = "Networking"
#   "Business Unit Code" = "DPS"
#   "Workload Architype" = "Internal Platform"
#   "Environment"        = "Dev"
#   "Environment Type"   = "Non Production"
#   "Architecture Type"  = "IaaS"
# }