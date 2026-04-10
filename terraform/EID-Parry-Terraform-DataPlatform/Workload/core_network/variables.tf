# Variables for Hub Network Workload
variable "nameConfig" {
  type = object({
    defaultLocation = string      //Location for the Resource to be Deployed.
    tags            = map(string) //"Tags are key-value pairs that help organize and manage resources by categorizing them (e.g., by environment, department, or purpose)."
    rg_creation     = string      //"Flag to indicate whether a new resource group should be created or existing resource group is used."
    environment     = string      //Deployment Environment (for example UAT or Prod).
    businessunit    = string      //Workload type of the resource
    identity        = string      //Flag to use in Naming Convention
  })
}

variable "hub_network" {
  type = object({
    address_space_vnet                     = list(string) //The address space for the virtual network.
    subnet_compute_address_prefix          = list(string) //A list of address prefixes for the compute subnet.
    subnet_vpn_address_prefix              = list(string) //The address prefix of VPN Gateway Subnet
    subnet_private_endpoint_address_prefix = list(string) //The address prefix of Private Endpoint Subnet
    subnet_nsg_association                 = bool         //subnet nsg assocation bool: defaults to true
    subnet_routetable_association          = bool         //subnet rt assocation bool: defaults to true
  })
}
