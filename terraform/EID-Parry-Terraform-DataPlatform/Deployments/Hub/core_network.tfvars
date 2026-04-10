nameConfig = {
  defaultLocation = "centralindia"
  rg_creation     = "existing"
  environment     = "hub"
  businessunit    = "ea"
  identity        = "eid"
  tags = {
    "Business Owner" = "EID"
    "Business Unit"  = "EA"
    "Environment"    = "Hub"
  }
}

hub_network = {
  address_space_vnet                     = ["172.30.12.0/23"]
  subnet_vpn_address_prefix              = ["172.30.12.0/26"]
  subnet_compute_address_prefix          = ["172.30.12.64/27"]
  subnet_private_endpoint_address_prefix = ["172.30.12.96/27"]
  subnet_nsg_association                 = false
  subnet_routetable_association          = false
}
