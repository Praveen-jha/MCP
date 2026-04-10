# Variable to define the address space for the virtual network
variable "address_space_vnet" {
  type        = list(string)
  description = "The address space for the virtual network."
}

# Variable to define tags for the NIC
variable "nic_tags" {
  type        = map(string)
  description = "A map of tags to assign to the NIC."
}

# Variable to define tags for the NSGs
variable "nsg_tags" {
  type        = map(string)
  description = "A map of tags to assign to the nsg."
}

# Variable to define tags for the virtual machine
variable "vm_tags" {
  type        = map(string)
  description = "A map of tags to assign to the virtual machine."
}

# Variable to define tags for the virtual network
variable "vnet_tags" {
  type        = map(string)
  description = "A map of tags to assign to the virtual network."
}

# Variable to define tags for the Private DNS Zones
variable "PDZ_tags" {
  type        = map(string)
  description = "A map of tags to assign to the private dns zone."
}

# Variable to define the address prefixes for the workload subnet
variable "subnet_workload1_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the workload subnet."
}

# Variable to define the address prefixes for the firewall subnet
variable "subnet_firewall_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the firewall subnet."
}

# Variable to define the address prefixes for private endpoint subnet
variable "subnet_pep_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the second subnet."
}

variable "subnet_nsg_association" {
  type    = bool
  default = false
}

# The geographical location where the resource group will be deployed.
variable "rg_location" {
  type        = string
  description = "Location of the resource group."
}

variable "subnet_routetable_association" {
  type = bool
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

# Variable to define the address prefixes for the bastion subnet
variable "subnet_bastion_address_prefix" {
  type        = list(string)
  description = "A list of address prefixes for the azure bastion subnet."
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

# The username for the administrator account to be created on the virtual machine.
# This is the account that will have admin privileges on the VM.
variable "admin_username" {
  type        = string
  description = "The username for the administrator account to be created on the virtual machine."
}

# The password for the administrator account. It is recommended to use a strong password.
# Ensure to avoid using weak or default passwords in production environments.
variable "password" {
  type        = string
  description = "The password for the administrator account. Make sure to use a strong password in production environments."
}

# The publisher of the Windows image for the virtual machine.
variable "windows_publisher" {
  type        = string
  description = "The publisher of the Windows image for the virtual machine."
}

# The offer of the Windows image for the virtual machine.
variable "windows_offer" {
  type        = string
  description = "The offer of the Windows image for the virtual machine."
}

# The SKU of the Windows image to be used for the virtual machine.
variable "windows_sku" {
  type        = string
  description = "The SKU of the Windows image."
}

# The size of the virtual machine, which determines the compute resources allocated (CPU, RAM, etc.).
variable "size" {
  type        = string
  description = "The size of the virtual machine. Default is Standard_F2."
}

# The SKU for the public IP address. Available options are Basic or Standard.
# Standard SKU offers additional features such as zone resiliency.
variable "ip_sku" {
  type        = string
  description = "The SKU for the public IP address. Options are Basic or Standard. Default is Standard."
}

# Specifies the SKU (Stock Keeping Unit) name for the resource.
# Typically used to define the size or type of Azure Firewall in a Virtual Network.
variable "Sku_Name" {
  type        = string
  description = "Specifies the SKU (Stock Keeping Unit) name for the resource, typically used to define the size or type of Azure Firewall in a Virtual Network."
}

# Defines the tier of the SKU for the resource.
# This might include tiers such as Standard, Premium, etc., based on the resource type.
variable "Sku_Tier" {
  type        = string
  description = "Defines the tier of the SKU for the resource."
}

# Specifies the allocation method for the IP address in the subnet.
# Common values include "Dynamic" or "Static" allocation for IP addresses.
variable "Subnet_Allocation_Method" {
  type        = string
  description = "Specifies the allocation method for the IP address in the subnet."
}

# Defines the SKU tier for the subnet, used for defining performance or capacity in certain configurations.
variable "Subnet_Sku" {
  type        = string
  description = "Defines the SKU tier for the subnet."
}

# The name of the Log Analytics Workspace (LAW), used to collect and analyze log data.
# LAW is used for monitoring and logging in Azure environments.
variable "LAW_name" {
  type        = string
  description = "The name of the Log Analytics Workspace (LAW) used for monitoring and logging."
}

# The name of the resource group where shared monitoring resources are hosted.
# This could include resources like Log Analytics, monitoring agents, or alerting rules.
variable "monitor_rg_name" {
  type        = string
  description = "The name of the shared resource group where common resources are hosted."
}

# List of custom DNS IP addresses to be used for virtual network.
variable "custom_dns_ip" {
  type        = list(string)
  description = "Custom DNS value for virtual network custom dns."
}

#Azure Bastion tags to be applied over Bastion host.
variable "bastion_tags" {
  type        = map(string)
  description = "Azure Bastion tags to be applied over Bastion host"
}

# Tags associated with the firewall policy, useful for organizing and managing resources.
variable "firewall_policy_tags" {
  type        = map(string)
  description = "Tags for the firewall policy, used to organize and manage the policy in Azure."
}

# Tags associated with the firewall, useful for organizing and managing resources.
variable "firewall_tags" {
  type        = map(string)
  description = "Tags to be applied for the azure firewall."
}

# Tags associated with the public ip.
variable "PIP_tags" {
  type        = map(string)
  description = "Tags to be applied for the public ip."
}

#Route Table tags to be associated with Route table.
variable "rt_tags" {
  type        = map(string)
  description = "A map of tags to apply to the Azure Route Table."
}

# Offer for the Windows virtual machine
variable "windows_offer_sonarqube_vm" {
  type        = string
  description = "The offer for the Windows virtual machine used to host SonarQube."
}

# Publisher of the SonarQube Windows virtual machine
variable "windows_publisher_sonarqube_vm" {
  type        = string
  description = "The publisher of the SonarQube Windows virtual machine."
}

# SKU for the SonarQube Windows virtual machine
variable "windows_sku_sonarqube_vm" {
  type        = string
  description = "The SKU for the SonarQube Windows virtual machine."
}

# Size for the SonarQube Windows virtual machine
variable "sonarqube_vm_size" {
  type        = string
  description = "The size of the SonarQube Windows virtual machine."
}

# Variable to define tags for the Sonarqube VM NIC
variable "sonarqube_nic_tags" {
  type        = map(string)
  description = "A map of tags to assign to the NIC."
}

# Variable to define tags for the Sonarqube virtual machine
variable "sonarqube_vm_tags" {
  type        = map(string)
  description = "A map of tags to assign to the virtual machine."
}

#Variable to define address prefix of VPN Gateway Subnet
variable "subnet_vpn_address_prefix" {
  type        = list(string)
  description = "The address prefix of VPN Gateway Subnet"
}

# The type of managed identity (e.g., SystemAssigned, UserAssigned).
variable "identity_type" {
  type        = string
  description = "The type of managed identity (e.g., SystemAssigned, UserAssigned)."
}
