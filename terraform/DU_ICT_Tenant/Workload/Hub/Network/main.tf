# ......................................................
# Creating New Resource Group _previous
# ......................................................

module "RG" {
  source                  = "../../../Modules/rg"
  count                   = var.rg_creation == "new" ? 1 : 0
  resource_group_name     = local.hub_network_rg_name
  resource_group_location = var.rg_location
}

# ......................................................
# Creating Hub Virtual Network
# ......................................................

module "vnet" {
  source                        = "../../../Modules/networking/virtualNetwork"
  new_virtual_network_name      = local.hub_virtual_network_name
  virtual_network_location      = local.location
  virtual_network_address_space = local.address_space_vnet
  resource_group_name           = local.resource_group_name
  dns_server                    = var.custom_dns_ip
  virtual_network_tags          = var.vnet_tags
  depends_on                    = [module.RG]
}

# ......................................................
# Creation of Workload Subnet1
# ......................................................

module "subnet_Workload1" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_Workload_name1
  subnet_address_prefixes                       = var.subnet_workload1_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  subnet_nsg_association                        = var.subnet_nsg_association
  rt_id                                         = module.route_table.route_table_id
  depends_on                                    = [module.vnet, module.route_table]
}

# ......................................................
# Creation of Bastion subnet
# ......................................................

module "subnet_Bastion" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_Bastion_name
  subnet_address_prefixes                       = var.subnet_bastion_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  subnet_rt_association                         = var.subnet_routetable_association
  nsg_id                                        = module.nsg_bastion.nsg_id
  depends_on                                    = [module.vnet, module.nsg_bastion]
}

# ......................................................
# Creating SHA VM
# ......................................................

module "self_hosted_agent_virtual_machine" {
  source                        = "../../../Modules/selfHostedAgent"
  resource_group_name           = local.resource_group_name
  location                      = local.location
  windows_vm_name               = local.vm_name
  admin_username                = var.admin_username
  password                      = var.password
  caching                       = local.caching
  computer_name                 = local.computer_name
  image_version                 = local.image_version
  private_ip_address_allocation = local.private_ip_address_allocation
  nic_name                      = local.network_interface_name
  size                          = var.size
  storage_account_type          = local.storage_account_type
  subnet_id                     = module.subnet_Workload1.subnet_id
  windows_offer                 = var.windows_offer
  windows_publisher             = var.windows_publisher
  windows_sku                   = var.windows_sku
  nic_ip_configuration_name     = local.nic_ip_configuration_name
  nsg_name                      = local.workload_nsg_name
  nsg_tags                      = var.nsg_tags
  sec_rule                      = local.nsg_security_rule
  depends_on                    = [module.RG]
  nic_tags                      = var.nic_tags
  vm_tags                       = var.vm_tags
}

# ......................................................
# Creating Bastion
# ......................................................

module "Bastion" {
  source                = "../../../Modules/networking/bastion"
  resource_group_name   = local.resource_group_name
  location              = local.location
  bastion_name          = local.bastion_name
  ip_configuration_name = local.bastion_ip_configuration_name
  subnet_id             = module.subnet_Bastion.subnet_id
  public_ip_name        = local.bastion_public_ip_name
  ip_allocation_method  = local.IP_allocation_method
  bastion_tags          = var.bastion_tags
  PIP_tags              = var.PIP_tags
  ip_sku                = var.ip_sku
  depends_on            = [module.subnet_Bastion]
}

# ......................................................
# Creating Private DNS Zone
# ......................................................

module "Private_Dns_Zone" {
  source                               = "../../../Modules/networking/privateDNSZone"
  count                                = length(local.private_dns_zone_name)
  private_dns_zone_name                = element(local.private_dns_zone_name, count.index)
  private_dns_zone_resource_group_name = local.resource_group_name
  private_dns_zone_tags                = var.PDZ_tags
  depends_on                           = [module.RG]
}

# ......................................................
# Creating Private DNS Zone Vnet Link
# ......................................................

module "Vnet_Link" {
  source                                = "../../../Modules/networking/virtualNetworkLink"
  count                                 = length(local.private_dns_zone_name)
  private_dns_link_name                 = local.Virtual_Network_Link_Name
  private_dns_link_registration_enabled = local.private_dns_link_registration_enabled
  private_dns_link_resource_group_name  = local.resource_group_name
  private_dns_link_virtual_network_id   = module.vnet.virtual_network_id
  private_dns_link_zone_name            = element(local.private_dns_zone_name, count.index)
  # private_dns_link_tags                 = var.vnet_link_tags

  depends_on = [module.RG, module.Private_Dns_Zone]
}

# ......................................................
# Creating Firewall Subnet
# ......................................................

module "subnet_Firewall" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_Firewall_name
  subnet_address_prefixes                       = var.subnet_firewall_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  subnet_rt_association                         = var.subnet_routetable_association
  subnet_nsg_association                        = var.subnet_nsg_association
  depends_on                                    = [module.vnet]
}

# ......................................................
# Creation of TFstate Storage Private Endpoint Subnet
# ......................................................

module "subnet_pep" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_pep_name
  subnet_address_prefixes                       = var.subnet_pep_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  subnet_delegations                            = local.subnet_delegation_null
  service_endpoints                             = local.service_endpoints
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies
  subnet_rt_association                         = var.subnet_routetable_association
  subnet_nsg_association                        = var.subnet_nsg_association
  depends_on                                    = [module.vnet]
}

# .......................................................
# Route Table 
# .......................................................

module "route_table" {
  source      = "../../../Modules/networking/routeTable"
  rt_name     = local.rt_name
  rt_location = local.location
  rt_rg_name  = local.resource_group_name
  rt_routes   = local.rt_routes
  rt_tags     = var.rt_tags
  depends_on  = [module.RG]
}

# ......................................................
# Creating Firewall
# ......................................................

module "Firewall" {
  source                   = "../../../Modules/firewall"
  Firewall_Name            = local.Firewall_Name
  Sku_Name                 = var.Sku_Name
  Sku_Tier                 = var.Sku_Tier
  Ip_Configuration_name    = local.Ip_Configuration_name
  location                 = local.location
  resource_group_name      = local.resource_group_name
  subnet_id                = module.subnet_Firewall.subnet_id
  PIP_Name                 = local.PIP_Name
  Subnet_Allocation_Method = var.Subnet_Allocation_Method
  Subnet_Sku               = var.Subnet_Sku
  firewall_policy_name     = local.firewall_policy_name
  firewall_policy_sku      = var.Sku_Tier
  firewall_policy_tags     = var.firewall_policy_tags
  firewall_tags            = var.firewall_tags
  PIP_tags                 = var.PIP_tags
  proxy_enabled            = local.proxy_enabled
  depends_on               = [module.subnet_Firewall]

}

# ......................................................
# Creating Diagnostic settings for Firewall
# ......................................................

module "diagnostic_setting" {
  source                     = "../../../Modules/monitoring/diagnosticSetting"
  diagnostic_setting_name    = local.diagnostic_setting_Name
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
  target_resource_id         = module.Firewall.firewall_id
  enabled_log                = local.enabled_logs
  metric                     = coalesce(local.metrics, [""])
  depends_on                 = [module.Firewall]
}

# ......................................................
# Creating NSG For Bastion Subnet
# ......................................................

module "nsg_bastion" {
  source       = "../../../Modules/networking/networkSecurityGroup"
  nsg_name     = local.bastion_nsg_name
  nsg_location = local.location
  nsg_rg_name  = local.resource_group_name
  sec_rule     = local.bastion_nsg_security_rule
  nsg_tags     = var.nsg_tags
  depends_on   = [module.RG]
}

# ......................................................
# Setting Custom DNS on Virtual Network for Firewall
# ......................................................

module "custom_dns" {
  source             = "../../../Modules/networking/virtualNetworkDNSServer"
  virtual_network_id = module.vnet.virtual_network_id
  custom_dns_ip      = var.custom_dns_ip
}

# ......................................................
# Creating SonarQube Virtual Machine
# ......................................................

module "sonarqube_vm" {
  source                        = "../../../Modules/virtualMachines"
  resource_group_name           = local.resource_group_name
  location                      = local.location
  windows_vm_name               = local.sonarqube_vm_name
  admin_username                = var.admin_username
  password                      = var.password
  caching                       = local.caching
  computer_name                 = local.sonarqube_computer_name
  image_version                 = local.image_version
  private_ip_address_allocation = local.private_ip_address_allocation
  nic_name                      = local.sonarqube_network_interface_name
  size                          = var.sonarqube_vm_size
  storage_account_type          = local.storage_account_type
  subnet_id                     = module.subnet_Workload1.subnet_id
  windows_offer                 = var.windows_offer_sonarqube_vm
  windows_publisher             = var.windows_publisher_sonarqube_vm
  windows_sku                   = var.windows_sku_sonarqube_vm
  nic_ip_configuration_name     = local.sonarqube_nic_ip_configuration_name
  nic_tags                      = var.sonarqube_nic_tags
  vm_tags                       = var.sonarqube_vm_tags
  identity_type                 = var.identity_type
  identity_ids                  = local.identity_ids
  depends_on                    = [module.RG]
}

# ......................................................
# Creation of VPN Gateway Subnet
# ......................................................

module "subnet_vpn" {
  source                                        = "../../../Modules/networking/subnet"
  subnet_name                                   = local.subnet_vpngw_name
  subnet_address_prefixes                       = var.subnet_vpn_address_prefix
  subnet_rg_name                                = local.resource_group_name
  virtual_network_name                          = local.hub_virtual_network_name
  service_endpoints                             = local.subnet_endpoints_null
  private_link_service_network_policies_enabled = local.private_link_service_network_policies_enabled_false
  private_endpoint_network_policies             = local.private_endpoint_network_policies_disabled
  subnet_nsg_association                        = false
  rt_id                                         = module.route_table_vpn.route_table_id
  depends_on                                    = [module.vnet, module.RG, module.route_table_vpn]
}

# ......................................................
# Creation of Route table for VPN Gateway Subnet
# ......................................................

module "route_table_vpn" {
  source      = "../../../Modules/networking/routeTable"
  rt_name     = local.rt_name_vpn
  rt_location = local.location
  rt_rg_name  = local.resource_group_name
  rt_routes   = local.route_table_vpn_routes
  rt_tags     = var.rt_tags
  depends_on  = [module.RG]
}
