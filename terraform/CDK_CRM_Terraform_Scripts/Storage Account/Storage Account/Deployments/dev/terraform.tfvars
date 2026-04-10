# Tfvars file for the Storage Account module in Terraform
location = "centralus"
tags = {
  Environment = "dev"
}

name_config = {
  storage_account_resource_group_creation = "existing"
  virtual_network_resource_group_creation = "existing"
  virtual_network_creation                = "existing"
  subnet_creation                         = "existing"
  environment                             = "dev"
  short_name                              = "mr"
  product_name                            = "crm"
  region_flag                             = "cus"
  instance                                = "01"
  application                             = "str"
}

storage_account_private_dns_zone_ids = [
  ""
]

storage_account = {
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = false
}

public_network_access_enabled = false
enable_private_dns_zone_group = true


new_storage_account_resource_group_name = "rg-mr-crm-dev-cus-01"

existing_resource_group_storage_account_name = "rg-mr-crm-dev-cus-01" //Not required if deploying new Resource Group
existing_resource_group_virtual_network_name = "rg-mr-crm-dev-vnet-cus-01"
existing_virtual_network_name                = "vnet-mr-crm-dev-cus-01"
existing_private_endpoint_subnet_name        = "snet-mr-crm-dev-pep-cus-01"
