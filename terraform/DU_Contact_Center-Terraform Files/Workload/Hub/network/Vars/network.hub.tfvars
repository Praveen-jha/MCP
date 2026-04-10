address_space_vnet                       = ["10.81.48.0/23"]
subnet_compute_address_prefix            = ["10.81.48.192/27"]
subnet_bastion_address_prefix            = ["10.81.48.128/26"]
subnet_firewall_address_prefix           = ["10.81.48.0/26"]
subnet_pep_address_prefix                = ["10.81.48.224/27"]
subnet_FirewallManagement_address_prefix = ["10.81.48.64/26"]
subnet_dnspr_inbound_address_prefix      = ["10.81.49.0/26"]
subnet_dnspr_outbound_address_prefix     = ["10.81.49.64/26"]
vnet_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Hub_Vnet"
  "Tier"               = "Networking"
  "Business Unit Code" = "DPS"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "IaaS"
}

PDZ_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Private_Dns_Zone"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "PaaS"
}

vnet_link_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Virtual_Network_link"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "PaaS"
}

bastion_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Shared_Azure_Bastion"
  "Business Unit Code" = "DPS"
  "Tier"               = "Security"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "PaaS"
}

PIP_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Public_IP"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "PaaS"
}

rt_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Hub_Route_Table"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "IaaS"
}

nsg_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Network_security_group"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "IaaS"
}
resource_group_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Resource_Group"
  "Business Unit Code" = "DPS"
  "Tier"               = "Networking"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "IaaS"
}
dnspr_tags = {
  "Workload Category"  = "Internal Workloads"
  "Workload Name"      = "Private DNS Resolver"
  "Tier"               = "Networking"
  "Business Unit Code" = "DPS"
  "Workload Architype" = "Internal Platform"
  "Environment"        = "Hub"
  "Environment Type"   = "Hub"
  "Architecture Type"  = "IaaS"
}

rg_location = "UAE North"
rg_creation = "new"
environment = "shrd-hub"
tenant_name = "ict"
ip_sku      = "Standard"
# Subnet_Allocation_Method      = "Static"
workload_type      = "network"
custom_dns_ip      = ["10.81.48.4"]
location_shortname = "uaen"


dns_resolver_forwarding_rules_config = {
  "rule-1" = { #corp-du-ae	corp.du.ae.	10.81.28.4:53, 10.81.28.5:53
    rule_name   = "corp-du-ae"
    domain_name = "corp.du.ae."
    enabled     = true
    target_dns_servers = [
      {
        ip_address = "10.81.28.4"
        port       = 53
      },
      {
        ip_address = "10.81.28.5"
        port       = 53
    }]
  },
  "rule-2" = { # du-ae	du.ae.	10.81.28.4:53, 10.81.28.5:53
    rule_name   = "du-ae"
    domain_name = "du.ae."
    enabled     = true
    target_dns_servers = [{
      ip_address = "10.81.28.4"
      port       = 53
      },
      {
        ip_address = "10.81.28.5"
        port       = 53
    }]
  },
  "rule-3" = { # menalab-corp-local	menalab.corp.local.	10.81.28.4:53, 10.81.28.5:53
    rule_name   = "menalab-corp-local"
    domain_name = "menalab.corp.local."
    enabled     = true
    target_dns_servers = [{
      ip_address = "10.81.28.4"
      port       = 53
      },
      {
        ip_address = "10.81.28.5"
        port       = 53
    }]
  }
}
