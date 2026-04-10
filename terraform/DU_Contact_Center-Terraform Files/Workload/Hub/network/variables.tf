# Variable to define the address space for the virtual network
variable "address_space_vnet" {
  type        = list(string)
  description = "The address space for the virtual network."
}

# Variable to define tags for the virtual network
variable "vnet_tags" {
  type        = map(string)
  description = "A map of tags to assign to the virtual network."
}

# Variable to define tags for the RG
variable "resource_group_tags" {
  type        = map(string)
  description = "A map of tags to assign to the RG."
}

# Variable to define tags for the Private DNS Zones
variable "PDZ_tags" {
  type        = map(string)
  description = "A map of tags to assign to the private dns zone."
}

variable "vnet_link_tags" {
  description = "Tags for the Private DNS zone"
  type        = map(string)
}

# Tags associated with the public ip.
variable "PIP_tags" {
  type        = map(string)
  description = "Tags to be applied for the public ip."
}

# The SKU for the public IP address. Available options are Basic or Standard.
# Standard SKU offers additional features such as zone resiliency.
variable "ip_sku" {
  type        = string
  description = "The SKU for the public IP address. Options are Basic or Standard. Default is Standard."
}


# Variable to define the address prefixes for the compute subnet
variable "subnet_compute_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the compute subnet."
}

# Variable to define the address prefixes for the firewall subnet
variable "subnet_firewall_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the firewall subnet."
}

# Variable to define the address prefixes for the DNS PR Inbound subnet
variable "subnet_dnspr_inbound_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the firewall subnet."
}

# Variable to define the address prefixes for the DNS PR Outbound subnet
variable "subnet_dnspr_outbound_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the firewall subnet."
}

#Azure DNS PR tags to be applied over DNS PR.
variable "dnspr_tags" {
  type        = map(string)
  description = "Azure DNS PR tags to be applied over DNS PR"
}

#Azure Bastion tags to be applied over Bastion host.
variable "bastion_tags" {
  type        = map(string)
  description = "Azure Bastion tags to be applied over Bastion host"
}

# # Variable to define the address prefixes for private endpoint subnet
variable "subnet_pep_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the second subnet."
}

# Variable to define the address prefixes for FirewallManagement subnet
variable "subnet_FirewallManagement_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the FirewallManagement subnet."
}

# Variable to define the address prefixes for the bastion subnet
variable "subnet_bastion_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the azure bastion subnet."
}

# The geographical location where the resource group will be deployed.
variable "rg_location" {
  type        = string
  description = "Location of the resource group."
}


# A flag to indicate whether the resource group should be created.
variable "rg_creation" {
  type        = string
  description = "Flag to indicate whether a new resource group should be created or existing resource group is used."
}

# Variable for the tenant name
variable "tenant_name" {
  type        = string
  description = "The name of the tenant."
}

# Variable for the environment name
variable "environment" {
  type        = string
  description = "The name of the environment."
}

variable "workload_type" {
  type        = string
  description = "workload type of the resource"
}

# Variable for the location name
variable "location_shortname" {
  type        = string
  description = "The geographical location of the resource."
}

# List of custom DNS IP addresses to be used for virtual network.
variable "custom_dns_ip" {
  type        = list(string)
  description = "Custom DNS value for virtual network custom dns."
}


# #Route Table tags to be associated with Route table.
variable "rt_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Route Table."
}

# NSG tags to be associated with subnet.
variable "nsg_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Route Table."
}

variable "dns_resolver_forwarding_rules_config" {
  type = map(object({
    rule_name   = string
    domain_name = string
    enabled     = bool
    target_dns_servers = list(object({
      ip_address = string
      port       = number
    }))
  }))
}

 
